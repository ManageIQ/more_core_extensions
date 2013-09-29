require_relative '../shared/nested'

module MoreCoreExtensions
  module HashNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    def delete_blank_paths
      self.each_value { |v| v.delete_blank_paths if v.respond_to?(:delete_blank_paths) }
      self.delete_blanks
    end

    def find_path(val)
      self.each do |k, v|
        return [k] if v == val

        c = v.respond_to?(:find_path) ? v.find_path(val) : []
        return c.unshift(k) unless c.blank?
      end
      []
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashNested)
