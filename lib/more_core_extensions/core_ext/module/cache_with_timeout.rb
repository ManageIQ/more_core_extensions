require 'sync'

$cache_with_timeout = {}
$cache_with_timeout_lock = Sync.new

module MoreCoreExtensions
  module CacheWithTimeout
    def cache_with_timeout(method, timeout = nil)
      raise "no block given" unless block_given?

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
          new_value   = yield

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
    end

    module ClassMethods
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
