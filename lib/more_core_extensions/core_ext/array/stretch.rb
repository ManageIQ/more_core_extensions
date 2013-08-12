module MoreCoreExtensions
  module ArrayStretch
    module ClassMethods
      # Stretch all argument Arrays to make them the same size.
      #
      #   Array.stretch([1, 2], [3, 4], [5, 6, 7])  #=> [[1, 2, nil], [3, 4, nil], [5, 6, 7]]
      def stretch(*arys)
        self.stretch!(*arys.collect { |a| a.dup })
      end

      # Stretch all argument Arrays to make them the same size.  Modifies the arguments in place.
      #
      #   Array.stretch!([1, 2], [3, 4], [5, 6, 7])  #=> [[1, 2, nil], [3, 4, nil], [5, 6, 7]]
      def stretch!(*arys)
        max_size = arys.collect { |a| a.length }.max
        arys.each { |a| a[max_size - 1] = nil unless a.length == max_size }
        return *arys
      end
    end

    # Stretch receiver to be the same size as the longest argument Array.
    #
    #   [1, 2].stretch([3, 4], [5, 6, 7])  #=> [1, 2, nil]
    def stretch(*arys)
      self.dup.stretch!(*arys)
    end

    # Stretch receiver to be the same size as the longest argument Array.  Modifies the receiver in place.
    #
    #   [1, 2].stretch!([3, 4], [5, 6, 7])  #=> [1, 2, nil]
    def stretch!(*arys)
      max_size = (arys + [self]).collect { |a| a.length }.max
      self[max_size - 1] = nil unless self.length == max_size
      return self
    end

    # Zip arguments stretching the receiver if necessary.  Ruby's +zip+ method
    # will only zip up to the number of the receiver's elements if the receiver
    # is shorter than the argument Arrays.  This method will zip nils instead of
    # stopping.
    #
    #   [1, 2].zip([3, 4], [5, 6, 7])  #=> [[1, 3, 5], [2, 4, 6]]
    #   [1, 2].zip_stretched([3, 4], [5, 6, 7])  #=> [[1, 3, 5], [2, 4, 6], [nil, nil, 7]
    def zip_stretched(*arys)
      self.stretch(*arys).zip(*arys)
    end
  end
end

Array.send(:extend, MoreCoreExtensions::ArrayStretch::ClassMethods)
Array.send(:include, MoreCoreExtensions::ArrayStretch)
