require 'more_core_extensions/core_ext/array/element_counts'

module MoreCoreExtensions
  module ArrayDuplicates
    #
    # Returns an Array of the duplicates found.
    #
    #   [1, 2, 3, 4, 2, 4].duplicates  #=> [2, 4]
    def duplicates
      element_counts.reject { |k, v| v == 1 }.keys
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayDuplicates)
