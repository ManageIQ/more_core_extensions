module MoreCoreExtensions
  module ArrayElementCounts
    # Returns a Hash of each element to the count of those elements.
    #
    #   [1, 2, 3, 1, 3, 1].counts  # => {1 => 3, 2 => 1, 3 => 2}
    def element_counts
      each_with_object(Hash.new(0)) { |i, h| h[i] += 1 }
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayElementCounts)
