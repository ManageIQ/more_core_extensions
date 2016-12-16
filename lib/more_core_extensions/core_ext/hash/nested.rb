require_relative '../shared/nested'

module MoreCoreExtensions
  module HashNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    #
    # Deletes all paths where the value is blank
    #
    def delete_blank_paths
      self.each_value { |v| v.delete_blank_paths if v.respond_to?(:delete_blank_paths) }
      self.delete_blanks
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashNested)
