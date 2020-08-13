module MoreCoreExtensions
  module WindowsTime
    module ClassMethods
      # Convert 64-bit FILETIME integer into Time object.
      def wtime_to_time(wtime)
        Time.utc(1601) + wtime.quo(10_000_000)
      end

      # Convert Time object or Integer object into 64-bit FILETIME.
      def time_to_wtime(time)
        time.gmtime.to_i * 10_000_000 + 116_444_736_000_000_000
      end
    end
  end
end

Time.send(:extend, MoreCoreExtensions::WindowsTime::ClassMethods)
