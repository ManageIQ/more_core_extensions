require 'active_support/core_ext/object/blank'

module MoreCoreExtensions
  module ArrayDeletes
    # Deletes all items where the value is nil
    #
    #   [1, [], nil].delete_nils # => [1, []]
    def delete_nils
      delete_if { |i| i.nil? }
    end

    # Deletes all items where the value is blank
    #
    #   [1, [], nil].delete_blanks # => [1]
    def delete_blanks
      delete_if { |i| i.blank? }
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayDeletes)