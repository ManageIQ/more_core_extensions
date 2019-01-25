require 'benchmark'

module MoreCoreExtensions
  module BenchmarkRealtimeStore
    # Stores the elapsed real time used to execute the given block in the given
    # hash for the given key and returns the result from the block.  If the hash
    # already has a value for that key, the time is accumulated.
    def realtime_store(hash, key)
      ret = nil
      r0 = Time.now
      begin
        ret = yield
      ensure
        r1 = Time.now
        hash[key] = (hash[key] || 0) + (r1.to_f - r0.to_f)
      end
      ret
    end

    # Stores the elapsed real time used to execute the given block for the given
    # key and returns the hash as well as the result from the block.  The hash is
    # stored globally, keyed on thread id, and is cleared once the topmost nested
    # call completes.  If the hash already has a value for that key, the time is
    # accumulated.
    def realtime_block(key, &block)
      hash = current_realtime

      if in_realtime_block?
        ret = realtime_store(hash, key, &block)
        return ret, hash
      else
        # Outermost block.
        begin
          self.current_realtime = hash
          begin
            ret = realtime_store(hash, key, &block)
            return ret, hash
          rescue Exception
            # Don't let timings be lost on exception when there is nobody else to pick them up.
            logger.info("Exception in realtime_block #{key.inspect} - Timings: #{hash.inspect}")
            raise
          ensure
            delete_current_realtime
          end
        ensure
          # A second layer of protection in case TimeoutError struck right after
          # setting self.current_realtime, or right before `delete_current_realtime`.
          # In those cases, current_realtime might (wrongly) still exist.
          delete_current_realtime if in_realtime_block?
        end
      end
    end

    def thread_unique_identifier
      # Forks inherit the @@realtime_by_tid and parent/child Thread.current.object_id
      # are equal, so we need to index into the hash with the pid too.
      "#{Process.pid}-#{Thread.current.object_id}"
    end

    def in_realtime_block?
      @@realtime_by_tid.key?(thread_unique_identifier)
    end

    def current_realtime
      @@realtime_by_tid[thread_unique_identifier] || Hash.new(0)
    end

    def current_realtime=(hash)
      @@realtime_by_tid[thread_unique_identifier] = hash
    end

    def delete_current_realtime
      @@realtime_by_tid.delete(thread_unique_identifier)
    end

    private def logger
      @logger ||= begin
        require 'logger'
        $log || Logger.new($stderr)
      end
    end

    @@realtime_by_tid = {}
  end
end

Benchmark.send(:extend, MoreCoreExtensions::BenchmarkRealtimeStore)
