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

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "simplecov"

  spec.add_runtime_dependency "activesupport", ">= 4.2.2" # Avoid CVE-2015-3227 - https://hakiri.io/technologies/rails/issues/145c129cb1290c
end
