require 'active_support/core_ext/object/blank'

module MoreCoreExtensions::HashDeletes
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
end

Hash.send(:include, MoreCoreExtensions::HashDeletes)
