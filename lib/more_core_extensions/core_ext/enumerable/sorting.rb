module MoreCoreExtensions
  module StableSorting
    def self.included(klass)
      klass.class_eval do
        # <b>DEPRECATED:</b> Please use <tt>tabular_sort</tt> instead.
        def stable_sort_by(*args)
          warn "[DEPRECATION] `stable_sort_by` is deprecated.  Please use `Array#tabular_sort` instead."
          to_a.tabular_sort(*args)
        end
      end
    end
  end
end

Enumerable.send(:include, MoreCoreExtensions::StableSorting)
