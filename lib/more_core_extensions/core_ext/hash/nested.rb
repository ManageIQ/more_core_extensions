require_relative '../shared/nested'

module MoreCoreExtensions
  module HashNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    def has_key_path?(*args)
      args = args.first if args.length == 1 && args.first.kind_of?(Array)
      raise ArgumentError, "must pass at least one key" if args.empty?

      key = args.first
      has_child = self.has_key?(key)
      return has_child if args.length == 1

      child = self[key]
      return false unless child.kind_of?(Hash)
      return child.has_key_path?(args[1..-1])
    end
    alias include_path? has_key_path?
    alias key_path?     has_key_path?
    alias member_path?  has_key_path?

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
