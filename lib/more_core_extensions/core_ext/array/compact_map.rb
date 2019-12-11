module MoreCoreExtensions
  module ArrayCompactMap
    # Collect non-nil results from the block.  Basically [].collect { |i| ... }.compact
    #
    #   [1,2,3,4,5].compact_map { |i| i * 2 if i.odd?} # => [2,6,10]
    def compact_map
      return enum_for(:compact_map) unless block_given?

      [].tap do |results|
        each do |i|
          result = yield(i)
          results << result if result
        end
      end
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayCompactMap)
