require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/object/try'

module MoreCoreExtensions
  module ClassHierarchy
    # Returns a tree-like Hash structure of all descendants.
    #
    #   require 'socket'
    #   IO.hierarchy
    #   # => {BasicSocket=>
    #   #      {Socket=>{},
    #   #       IPSocket=>{TCPSocket=>{TCPServer=>{}}, UDPSocket=>{}},
    #   #       UNIXSocket=>{UNIXServer=>{}}},
    #   #     File=>{}}
    def hierarchy
      subclasses.each_with_object({}) { |k, h| h[k] = k.hierarchy }
    end

    # Returns an Array of all superclasses.
    #
    #   require 'socket'
    #   TCPServer.lineage
    #   # => [TCPSocket, IPSocket, BasicSocket, IO, Object, BasicObject]
    def lineage
      superclass.nil? ? [] : superclass.lineage.unshift(superclass)
    end
  end
end

Class.send(:include, MoreCoreExtensions::ClassHierarchy)
