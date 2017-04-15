require 'active_support/core_ext/object/blank'

module MoreCoreExtensions
  module HashDeletes
    # Deletes all keys where the value is nil
    #
    #   {:a => 1, :b => [], :c => nil}.delete_nils # => {:a => 1, :b => []}
    def delete_nils
      delete_if { |k, v| v.nil? }
    end

    # Deletes all keys where the value is blank
    #
    #   {:a => 1, :b => [], :c => nil}.delete_blanks # => {:a => 1}
    def delete_blanks
      delete_if { |k, v| v.blank? }
    end

    # Similar to #delete_blanks, but handles nested hashes
    #
    #   {:a=>{:b=>{:c=>[]}}, :x=>{:y=>{:z=>1}}}.purge_blanks
    #   # => {:x=>{:y=>{:z=>1}}}
    def purge_blanks
      self.each { |k, v| self[k].purge_blanks if v.kind_of?(Hash) }
      self.delete_blanks
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashDeletes)
