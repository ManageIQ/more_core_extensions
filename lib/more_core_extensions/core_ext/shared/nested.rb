module MoreCoreExtensions
  module Shared
    module Nested
      def fetch_path(*args)
        args = args.first if args.length == 1 && args.first.kind_of?(Array)
        raise ArgumentError, "must pass at least one key" if args.empty?

        child = self[args.first]
        return child if args.length == 1
        return nil unless child.kind_of?(Hash)
        return child.fetch_path(args[1..-1])
      end

      def store_path(*args)
        raise ArgumentError, "must pass at least one key, and a value" if args.length < 2
        value = args.pop
        args = args.first if args.length == 1 && args.first.kind_of?(Array)

        key = args.first
        if args.length == 1
          self[key] = value
        else
          child = self[key]
          unless child.kind_of?(Hash)
            self[key] = self.class.new
            child = self[key]
          end
          child.store_path(args[1..-1], value)
        end
      end
    end
  end
end