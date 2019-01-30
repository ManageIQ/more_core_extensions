require 'more_core_extensions/core_ext/numeric/math'

module MoreCoreExtensions
  module MathSlope
    module ClassMethods
      # Finds the y coordinate given x, slope of the line and the y intercept
      #
      # `y = mx + b`
      # Where `m` is the slope of the line and `b` is the y intercept
      #
      #    Math.slope_y_intercept(1, 0.5, 1) # => 1.5
      def slope_y_intercept(x, slope, y_intercept)
        slope * x + y_intercept
      end

      # Finds the x coordinate given y, slope of the line and the y intercept
      #
      # `x = (y - b) / m`
      # Where `m` is the slope of the line and `b` is the y intercept
      #
      #    Math.slope_x_intercept(1.5, 0.5, 1) # => 1.0
      def slope_x_intercept(y, slope, y_intercept)
        (y - y_intercept) / slope.to_f
      end

      # Finds the linear regression of the given coordinates.  Coordinates should be given as x, y pairs.
      #
      # Returns the slope of the line, the y intercept, and the R-squared value.
      #
      #    Math.linear_regression([1.0, 1.0], [2.0, 2.0]) # => [1.0, 0.0, 1.0]
      def linear_regression(*coordinates)
        return if coordinates.empty?

        x_array, y_array = coordinates.transpose
        sum_x  = x_array.sum
        sum_x2 = x_array.map(&:square).sum
        sum_y  = y_array.sum
        sum_y2 = y_array.map(&:square).sum
        sum_xy = coordinates.map { |x, y| x * y }.sum

        n = coordinates.size.to_f
        slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x.square)
        return if slope.nan?

        y_intercept = (sum_y - slope * sum_x) / n
        r_squared   = (n * sum_xy - sum_x * sum_y) / Math.sqrt((n * sum_x2 - sum_x.square) * (n * sum_y2 - sum_y.square)) rescue nil

        return slope, y_intercept, r_squared
      end
    end
  end
end

Math.send(:extend, MoreCoreExtensions::MathSlope::ClassMethods)
