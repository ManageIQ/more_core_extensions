module MoreCoreExtensions
  module ModuleNamespace
    #
    # Returns an Array with the namespace to the current Module.
    #
    #   Aaa::Bbb::Ccc::Ddd.namespace      #=> ["Aaa", "Bbb", "Ccc", "Ddd"]
    def namespace
      name.to_s.split("::")
    end
  end
end

Module.send(:include, MoreCoreExtensions::ModuleNamespace)
