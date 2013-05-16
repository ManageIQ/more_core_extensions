module MoreCoreExtensions::ArrayDuplicates
  #
  # Returns an Array of the duplicates found.
  #
  #   [1, 2, 3, 4, 2, 4].duplicates  #=> [2, 4]
  def duplicates
    self.inject(Hash.new(0)) { |h, v| h[v] += 1; h }.reject { |k, v| v == 1 }.keys
  end
end

Array.send(:include, MoreCoreExtensions::ArrayDuplicates)
