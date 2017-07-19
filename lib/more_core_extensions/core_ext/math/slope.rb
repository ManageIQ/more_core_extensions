require 'more_core_extensions/core_ext/numeric/math'

module MoreCoreExtensions
  module MathSlope
    module ClassMethods
      # Finds the y coordinate given x, slope of the line and the y intercept
      # `y = mx + b`
      # Where m is the slope of the line and b is the y intercept (the location where the line crosses the y axis)
      #
      #    Math.slope_y_intercept(1, 0.5, 1) # => 1.5
      def slope_y_intercept(x, slope, y_intercept)
        slope * x + y_intercept
      end

      # Finds the x coordinate given y, slope of the line and the y intercept
      # `x = (y - b) / m`
      # Where m is the slope of the line and b is the y intercept (the location where the line crosses the y axis)
      #
      #    Math.slope_x_intercept(1.5, 0.5, 1) # => 1.0
      def slope_x_intercept(y, slope, y_intercept)
        (y - y_intercept) / slope
      end

      # Finds the linear regression of the given coordinates.  Coordinates should be given as x, y pairs.
      #
      # Returns the slope of the line, the y intercept (the location where the line crosses the y axis), and the
      # R-squared value (how close the data fits to the trend line)
      #
      #    Math.linear_regression([1.0, 1.0], [2.0, 2.0]) # => [1.0, 0.0, 1.0]
      def linear_regression(*coordinates)
        return if coordinates.empty?

        n = coordinates.length
        x_array, y_array = coordinates.transpose

        sum_x = x_array.sum
        sum_y = y_array.sum

        xy_array = []
        n.times { |i| xy_array.push(x_array[i] * y_array[i]) }

        sum_xy = xy_array.sum

        x2_array = x_array.inject([]) { |a, v| a.push(v.square) }
        y2_array = y_array.inject([]) { |a, v| a.push(v.square) }

        sum_x2 = x2_array.sum
        sum_y2 = y2_array.sum

        slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x.square)
        return [] if slope.nan?
        y_intercept = (sum_y - slope * sum_x) / n
        r_squared = (n * sum_xy - sum_x * sum_y) / Math.sqrt((n * sum_x2 - sum_x.square) * (n * sum_y2 - sum_y.square)) rescue nil

        return slope, y_intercept, r_squared
      end
    end
  end
end

Math.send(:extend, MoreCoreExtensions::MathSlope::ClassMethods)
