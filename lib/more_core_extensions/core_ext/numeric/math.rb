module MoreCoreExtensions
  module NumericMath
    #
    # Returns the square of a Numeric.
    #
    #   2.square     #=> 4
    #   10.0.square  #=> 100.0
    def square
      self * self
    end
  end
end

Numeric.send(:prepend, MoreCoreExtensions::NumericMath)
