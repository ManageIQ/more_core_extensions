module MoreCoreExtensions
  module Shared
    module Nested
      #
      # Delete the value at the specified nesting
      #
      def delete_path(*args)
        args = args.first if args.length == 1 && args.first.kind_of?(Array)
        raise ArgumentError, "must pass at least one key" if args.empty?

        key = args.first
        raise ArgumentError, "must be a number" if self.kind_of?(Array) && !key.kind_of?(Numeric)

        child = self[key]
        if args.length == 1 || !child.respond_to?(:delete_path)
          self.kind_of?(Array) ? self.delete_at(key) : self.delete(key)
        else
          child.delete_path(args[1..-1])
        end
      end

      #
      # Fetch the value at the specific nesting
      #
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

      #
      # Check if a key exists at the specified nesting
      #
      def has_key_path?(*args)
        args = args.first if args.length == 1 && args.first.kind_of?(Array)
        raise ArgumentError, "must pass at least one key" if args.empty?

        key = args.first
        raise ArgumentError, "must be a number" if self.kind_of?(Array) && !key.kind_of?(Numeric)

        has_child = self.kind_of?(Array) ? self.includes_index?(key) : self.has_key?(key)
        return has_child if args.length == 1

        child = self[key]
        return false unless child.respond_to?(:has_key_path?)
        return child.has_key_path?(args[1..-1])
      end
      alias include_path? has_key_path?
      alias key_path?     has_key_path?
      alias member_path?  has_key_path?

      #
      # Store a value at the specified nesting
      #
      def store_path(*args)
        raise ArgumentError, "must pass at least one key, and a value" if args.length < 2
        value = args.pop
        child = self
        key   = args.first

        if args.length > 1 || args.first.kind_of?(Array)
          keys = args.first.kind_of?(Array) ? args.first : args
          keys.each_with_index do |cur_key, i|
            raise ArgumentError, "must be a number" if child.kind_of?(Array) && !cur_key.kind_of?(Numeric)
            key = cur_key # keep track of this for value assignment later
            break if i + 1 == keys.size

            unless child[cur_key].respond_to?(:store_path)
              child[cur_key] = child.class.new
            end

            child = child[cur_key]
          end
        end

        child[key] = value
      end

      #
      # Detect which nesting holds the specified value
      #
      def find_path(val)
        self.each_with_index do |v, k|
          k, v = v if self.kind_of?(Hash)
          return [k] if v == val

          c = v.respond_to?(:find_path) ? v.find_path(val) : []
          return c.unshift(k) unless c.blank?
        end
        []
      end
    end
  end
end
