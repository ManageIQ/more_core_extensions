module MoreCoreExtensions
  module HashNested
    def fetch_path(*args)
      args = args.first if args.length == 1 && args.first.kind_of?(Array)
      raise ArgumentError, "must pass at least one key" if args.empty?

      child = self[args.first]
      return child if args.length == 1
      return nil unless child.kind_of?(Hash)
      return child.fetch_path(args[1..-1])
    end

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

    def store_path(*args)
      raise ArgumentError, "must pass at least one key, and a value" if args.length < 2
      value = args.pop
      args = args.first if args.length == 1 && args.first.kind_of?(Array)

      key = args.first
      if args.length == 1
        self[key] = value
      else
        child = self[key]
        child = self[key] = {} unless child.kind_of?(Hash)
        child.store_path(args[1..-1], value)
      end
    end

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
