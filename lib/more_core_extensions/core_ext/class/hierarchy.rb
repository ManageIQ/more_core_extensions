require 'active_support'
require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/object/try'

module MoreCoreExtensions
  module ClassHierarchy
    # Returns the descendant with a given name
    #
    #   require 'socket'
    #   IO.descendant_get("IO")
    #   # => IO
    #   IO.descendant_get("BasicSocket")
    #   # => BasicSocket
    #   IO.descendant_get("IPSocket")
    #   # => IPSocket
    def descendant_get(desc_name)
      return self if desc_name == name || desc_name.nil?
      klass = descendants.find { |desc| desc.name == desc_name }
      raise ArgumentError, "#{desc_name} is not a descendant of #{name}" unless klass
      klass
    end

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

    # Returns an Array of all descendants which have no subclasses
    #
    #   require 'socket'
    #   BasicSocket.leaf_subclasses
    #   # => [Socket, TCPServer, UDPSocket, UNIXServer]
    def leaf_subclasses
      descendants.select { |d| d.subclasses.empty? }
    end
  end
end

Class.send(:include, MoreCoreExtensions::ClassHierarchy)
