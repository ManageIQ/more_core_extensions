module MoreCoreExtensions
  module ArrayElementCounts
    # Returns a Hash of each element to the count of those elements.  Optionally
    #  pass a block to count by a different criteria.
    #
    #   [1, 2, 3, 1, 3, 1].counts  # => {1 => 3, 2 => 1, 3 => 2}
    #   %w(a aa aaa a aaa a).counts { |i| i.length }  # => {1 => 3, 2 => 1, 3 => 2}
    #
    def element_counts
      each_with_object(Hash.new(0)) do |i, h|
        key = block_given? ? yield(i) : i
        h[key] += 1
      end
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayElementCounts)
