module MoreCoreExtensions
  module ArrayRandom
    #
    # Picks a valid index randomly
    #
    #   [1, 2, 3, 4, 2, 4].random_index  #=> random number between 0..5
    def random_index
      rand(self.size)
    end

    #
    # Picks an element randomly
    #
    #   [1, 2, 3, 4, 2, 4].random_element  #=> any randomly selected element in Array
    def random_element
      self[self.random_index]
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayRandom)
