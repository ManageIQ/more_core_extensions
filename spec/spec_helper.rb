require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "more_core_extensions/all"

puts
puts "\e[93mUsing ActiveSupport #{ActiveSupport.version}\e[0m"
