require "logger" # Require logger due to active_support breaking on Rails <= 7.0. See https://github.com/rails/rails/pull/54264
require 'active_support'
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

    # Deletes all keys and subkeys that match +key+.
    #
    #   {:a => {:b => 2, :c => 3}}.deep_delete(:b) # => {:a => {:c => 3}}
    #
    def deep_delete(key)
      key = [key] unless key.kind_of?(Array)
      key.each { |k| delete(k) }
      each_value { |v| v.deep_delete(key) if v.respond_to?(:deep_delete) }
    end
  end
end

Hash.send(:include, MoreCoreExtensions::HashDeletes)
