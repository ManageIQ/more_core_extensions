module MoreCoreExtensions
  module HashSortBang
    def sort!(*args, &block)
      sorted = sort(*args, &block)
      sorted = self.class[sorted.to_a] unless sorted.instance_of?(self.class)
      replace(sorted)
    end
  end

  module HashSortByBang
    def sort_by!(*args, &block)
      sorted = sort_by(*args, &block)
      sorted = self.class[sorted.to_a] unless sorted.instance_of?(self.class)
      replace(sorted)
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashSortBang) unless Hash.method_defined?(:sort!)
Hash.send(:include, MoreCoreExtensions::HashSortByBang) unless Hash.method_defined?(:sort_by!)
