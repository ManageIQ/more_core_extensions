module MoreCoreExtensions
  module EnumerableDeepClone
    # Create a deep clone of the enumerable object. This is similar to deep_dup
    # but uses a Marshal based approach instead.
    #
    #   h1 = {:a => "hello"}
    #   h2 = h1.deep_clone
    #
    #   h1[:a] << " world"
    #
    #   h1[:a] # "hello world"
    #   h2[:a] # "hello"
    #
    def deep_clone
      Marshal.load(Marshal.dump(self))
    end
  end
end

Enumerable.send(:include, MoreCoreExtensions::EnumerableDeepClone)
