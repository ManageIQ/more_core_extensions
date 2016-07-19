module MoreCoreExtensions
  module NumericRounding
    def round_up(nearest = 1)
      return self if nearest == 0
      return self if (self % nearest) == 0
      self + nearest - (self % nearest)
    end

    def round_down(nearest = 1)
      return self if nearest == 0
      return self if (self % nearest) == 0
      self - (self % nearest)
    end
  end
end

Numeric.send(:prepend, MoreCoreExtensions::NumericRounding)
