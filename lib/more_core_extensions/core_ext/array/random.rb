module MoreCoreExtensions
  module ArrayRandom
    #
    # Picks a valid index randomly
    #
    #   [1, 2, 3, 4, 2, 4].random_index  # => random number between 0..5
    def random_index
      case self.size
      when 0; nil
      when 1; 0
      else    rand(0...self.size)
      end
    end

    #
    # Picks an element randomly
    #
    #   [1, 2, 3, 4, 2, 4].random_element  # => random element in Array
    def random_element
      sample
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayRandom)
