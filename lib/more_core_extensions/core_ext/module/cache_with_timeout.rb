require 'sync'

$cache_with_timeout = {}
$cache_with_timeout_lock = Sync.new

module MoreCoreExtensions
  module CacheWithTimeout
    # cache_with_timeout creates singleton methods that cache the
    #   results of the given block, but only for a short amount of time.
    #   If the method is called again after time has passed, then the
    #   cache is cleared and the block is reevaluated.  Note that the
    #   cache is only cleared on the next invocation after the time has
    #   passed, so if the block retains references to large objects,
    #   they will never be garbage collected if the method is never
    #   called again.
    #
    #   The methods created are
    #   - `method`
    #   - `#{method}_clear_cache` - Will clear the cached value on demand
    #   - `#{method}_cached?` - Says whether or not there is a value cached
    #
    # Example:
    #    class Foo
    #      cache_with_timeout(:expensive_operation) do
    #        sleep 100
    #        rand(100)
    #      end
    #    end
    #
    #    Foo.expensive_operation # => 42
    #    Foo.expensive_operation # => 42
    #    # ... wait 5+ minutes ...
    #    Foo.expensive_operation # => 18
    #
    # @param [String|Symbol] method The name of the method to create.
    # @param [Integer] timeout The number of seconds after which the cache is
    #   cleared (defaults to: 300 (5 minutes))
    # @returns [Symbol] The name of the method created.
    def cache_with_timeout(method, timeout = nil, &block)
      raise "no block given" if block.nil?
      raise ArgumentError, "method must be a Symbol" unless method.respond_to?(:to_sym)

      key = "#{name}.#{method}".to_sym

      $cache_with_timeout_lock.synchronize(:EX) do
        $cache_with_timeout[key] = {}
      end

      define_singleton_method(method) do |*args|
        force_reload = args.first
        return $cache_with_timeout_lock.synchronize(:EX) do
          cache = $cache_with_timeout[key]

          old_timeout = cache[:timeout]
          cache.clear if force_reload || (old_timeout && Time.now.utc > old_timeout)
          break cache[:value] if cache.key?(:value)

          new_timeout = timeout || 300 # 5 minutes
          new_timeout = new_timeout.call if new_timeout.kind_of?(Proc)
          new_timeout = Time.now.utc + new_timeout
          new_value   = block.call

          cache[:timeout] = new_timeout
          cache[:value]   = new_value
        end
      end

      define_singleton_method("#{method}_clear_cache") do |*_args|
        $cache_with_timeout_lock.synchronize(:EX) do
          $cache_with_timeout[key].clear
        end
      end

      define_singleton_method("#{method}_cached?") do |*_args|
        $cache_with_timeout_lock.synchronize(:EX) do
          !$cache_with_timeout[key].empty?
        end
      end

      method.to_sym
    end

    module ClassMethods
      # Globally clears all cached values across all classes.  This is
      #   mostly useful for testing to avoid test contamination.
      #
      # Example:
      #    RSpec.configure do |c|
      #      c.after { Module.clear_all_cache_with_timeout }
      #    end
      def clear_all_cache_with_timeout
        $cache_with_timeout_lock.synchronize(:EX) do
          $cache_with_timeout.each_value(&:clear)
        end
      end
    end
  end
end

Module.send(:include, MoreCoreExtensions::CacheWithTimeout)
Module.send(:extend, MoreCoreExtensions::CacheWithTimeout::ClassMethods)
