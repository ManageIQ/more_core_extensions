# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'more_core_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "more_core_extensions"
  spec.version       = MoreCoreExtensions::VERSION
  spec.authors       = ["Jason Frey", "Brandon Dunne"]
  spec.email         = ["fryguy9@gmail.com", "bdunne@redhat.com"]
  spec.description   = %q{MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.}
  spec.summary       = spec.description
  spec.homepage      = "http://github.com/ManageIQ/more_core_extensions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib/*`.split("\n")
  spec.files        += %w[README.md LICENSE.txt]
  spec.executables   = `git ls-files -- bin/*`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.test_files   += %w[.rspec]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"

  # HACK: Rails 5 dropped support for Ruby < 2.2.2
  active_support_version = "< 5" if Gem::Version.new(RUBY_VERSION) <= Gem::Version.new("2.2.2")
  spec.add_runtime_dependency "activesupport", active_support_version
end
