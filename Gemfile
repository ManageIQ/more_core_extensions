source 'https://rubygems.org'

plugin 'bundler-inject'
require File.join(Bundler::Plugin.index.load_paths("bundler-inject")[0], "bundler-inject") rescue nil

# Specify your gem's dependencies in more_core_extensions.gemspec
gemspec

# Rails 5 dropped support for Ruby < 2.2.2
# Rails 6 dropped support for Ruby < 2.4.4
if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.2.2")
  active_support_version = "< 5"
elsif Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4.4")
  active_support_version = "< 6"
end
gem 'activesupport', active_support_version
