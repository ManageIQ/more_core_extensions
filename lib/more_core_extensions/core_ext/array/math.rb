require 'active_support/core_ext/enumerable' # For Array#sum

module MoreCoreExtensions
  module ArrayMath
    #
    # Returns the mean of an Array of Numerics.
    #
    #   [1, 2, 3, 4, 5].mean  #=> 3.0
    #   [1.0, 2.0, 3.0].mean  #=> 2.0
    def mean
      return 0.0 if empty?
      sum.to_f / length
    end

    #
    # Returns the standard deviation of an Array of Numerics.
    #
    #   [1, 2, 3, 4, 5].stddev  #=> 1.5811388300841898
    #   [1.0, 2.0, 3.0].stddev  #=> 1.0
    def stddev
      Math.sqrt(variance)
    end

    #
    # Returns the variance of an Array of Numerics.
    #
    #   [1, 2, 3, 4, 5].variance  #=> 2.5
    #   [1.0, 2.0, 3.0].variance  #=> 1.0
    def variance
      divisor = length - 1
      return 0.0 unless divisor > 0
      μ = mean
      reduce(0) { |m, i| m + (i - μ).square } / (length - 1)
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayMath)
