require_relative '../shared/nested'

module MoreCoreExtensions
  module ArrayNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    #
    # Deletes all paths where the value is blank
    #
    def delete_blank_paths
      self.each { |v| v.delete_blank_paths if v.respond_to?(:delete_blank_paths) }
      self.delete_blanks
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayNested)
