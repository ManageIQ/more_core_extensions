module MoreCoreExtensions
  module ArrayInclusions
    #
    # Returns whether the Array contains any of the items.
    #
    #   [1, 2, 3].include_any?(1, 2)  #=> true
    #   [1, 2, 3].include_any?(1, 4)  #=> true
    #   [1, 2, 3].include_any?(4, 5)  #=> false
    def include_any?(*items)
      items = items.first if items.length == 1 && items.first.kind_of?(Array)
      !(self & items).empty?
    end

    #
    # Returns whether the Array contains none of the items.
    #
    #   [1, 2, 3].include_none?(1, 2)  #=> false
    #   [1, 2, 3].include_none?(1, 4)  #=> false
    #   [1, 2, 3].include_none?(4, 5)  #=> true
    def include_none?(*items)
      items = items.first if items.length == 1 && items.first.kind_of?(Array)
      (self & items).empty?
    end

    #
    # Returns whether the Array contains all of the items.
    #
    #   [1, 2, 3].include_all?(1, 2)  #=> true
    #   [1, 2, 3].include_all?(1, 4)  #=> false
    #   [1, 2, 3].include_all?(4, 5)  #=> false
    def include_all?(*items)
      items = items.first if items.length == 1 && items.first.kind_of?(Array)
      (items - self).empty?
    end

    #
    # Returns whether the Array has a value at the index.
    #
    #   [1, 2, 3].includes_index?(-4)  #=> false
    #   [1, 2, 3].includes_index?(-3)  #=> true
    #   [1, 2, 3].includes_index?(1)  #=> true
    #   [1, 2, 3].includes_index?(2)  #=> true
    #   [1, 2, 3].includes_index?(3)  #=> false
    def includes_index?(index)
      (-self.length...self.length).cover?(index)
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayInclusions)
