require 'more_core_extensions/core_ext/module/namespace'

module MoreCoreExtensions
  module ObjectNamespace
    #
    # Returns whether or not the object is in the given namespace.
    #
    #   Aaa::Bbb::Ccc::Ddd.in_namespace?(Aaa::Bbb)            #=> true
    #   Aaa::Bbb::Ccc::Ddd.new.in_namespace?(Aaa::Bbb)        #=> true
    #   Aaa::Bbb::Ccc::Eee.in_namespace?("Aaa::Bbb")          #=> true
    #   Aaa::Bbb::Ccc::Eee.in_namespace?(Aaa::Bbb::Ccc::Ddd)  #=> false
    def in_namespace?(val)
      val_ns = val.to_s.split("::")
      val_ns == namespace[0, val_ns.length]
    end

    #
    # Returns an Array with the namespace to an Instance.
    #
    #   Aaa::Bbb::Ccc::Ddd.new.namespace  #=> ["Aaa", "Bbb", "Ccc", "Ddd"]
    def namespace
      self.class.namespace
    end
  end
end

Object.send(:include, MoreCoreExtensions::ObjectNamespace)
