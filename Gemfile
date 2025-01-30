source 'https://rubygems.org'

plugin 'bundler-inject'
require File.join(Bundler::Plugin.index.load_paths("bundler-inject")[0], "bundler-inject") rescue nil

# Specify your gem's dependencies in more_core_extensions.gemspec
gemspec

minimum_version =
  case ENV.fetch("TEST_RAILS_VERSION", "7.2")
  when "7.2"
    "~>7.2.2"
  when "7.1"
    "~>7.1.5"
  when "7.0"
    "~>7.0.8"
  when "6.1"
    "~>6.1.7"
  when "6.0"
    "~>6.0.6"
  else
    raise "Unexpected Rails version #{ENV['TEST_RAILS_VERSION'].inspect}"
  end

gem "activesupport", minimum_version
