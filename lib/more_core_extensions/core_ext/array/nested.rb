require_relative '../shared/nested'

module MoreCoreExtensions
  module ArrayNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested

    def delete_blank_paths
      self.each { |v| v.delete_blank_paths if v.respond_to?(:delete_blank_paths) }
      self.delete_blanks
    end

    def find_path(val)
      self.each_with_index do |v, k|
        return [k] if v == val

        c = v.respond_to?(:find_path) ? v.find_path(val) : []
        return c.unshift(k) unless c.blank?
      end
      []
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayNested)