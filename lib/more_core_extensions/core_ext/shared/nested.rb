module MoreCoreExtensions
  module Shared
    module Nested
      def fetch_path(*args)
        args = args.first if args.length == 1 && args.first.kind_of?(Array)
        raise ArgumentError, "must pass at least one key" if args.empty?

        key = args.first
        raise ArgumentError, "must be a number" if self.kind_of?(Array) && !key.kind_of?(Numeric)

        child = self[key]
        return child if args.length == 1
        return nil unless child.respond_to?(:fetch_path)
        return child.fetch_path(args[1..-1])
      end

      def store_path(*args)
        raise ArgumentError, "must pass at least one key, and a value" if args.length < 2
        value = args.pop
        args = args.first if args.length == 1 && args.first.kind_of?(Array)

        key = args.first
        raise ArgumentError, "must be a number" if self.kind_of?(Array) && !key.kind_of?(Numeric)

        if args.length == 1
          self[key] = value
        else
          child = self[key]
          unless child.respond_to?(:store_path)
            self[key] = self.class.new
            child = self[key]
          end
          child.store_path(args[1..-1].push, value)
        end
      end
    end
  end
end
