require_relative '../shared/nested'

module MoreCoreExtensions
  module HashNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    def delete_path(*args)
      args = args.first if args.length == 1 && args.first.kind_of?(Array)
      raise ArgumentError, "must pass at least one key" if args.empty?

      key = args.first
      if args.length == 1 || !(child = self[key]).kind_of?(Hash)
        self.delete(key)
      else
        child.delete_path(args[1..-1])
      end
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashNested)
