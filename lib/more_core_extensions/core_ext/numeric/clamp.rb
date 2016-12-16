module MoreCoreExtensions
  module NumericClamp
    #
    # Clamp a number to a minimum and/or maximum value.
    #
    #   8.clamp(nil, nil) #=> 8
    #   8.clamp(9, nil)   #=> 9
    #   8.clamp(nil, 6)   #=> 6
    def clamp(min, max)
      value = self
      value = [value, min].max if min
      value = [value, max].min if max
      value
    end
  end
end

Numeric.send(:prepend, MoreCoreExtensions::NumericClamp)
