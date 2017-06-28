require 'active_support/core_ext/class/subclasses'

module MoreCoreExtensions
  module Descendants
    #
    # Retrieve a descendant by its name
    #
    def descendant_get(desc_name)
      return self if desc_name == name || desc_name.nil?
      klass = descendants.find { |desc| desc.name == desc_name }
      raise ArgumentError, "#{desc_name} is not a descendant of #{name}" unless klass
      klass
    end
  end
end

Object.send(:include, MoreCoreExtensions::Descendants)
