module MoreCoreExtensions
  module StringSplitters
    # Split a string (left to right) like String#split, but guarantee the number of
    #  desired_items in the array by filling with blank strings if needed
    def lsplit(string, desired_items = 0)
      arr = self.split(string, desired_items)
      desired_items == 0 ? arr : arr.fill("", arr.length..(desired_items-1))
    end

    # Same as lsplit, opposite direction (right to left)
    def rsplit(string, desired_items = 0)
      self.reverse.lsplit(string.reverse, desired_items).reverse.collect { |s| s.reverse}
    end
  end
end

String.send(:include, MoreCoreExtensions::StringSplitters)