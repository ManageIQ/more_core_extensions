# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'more_core_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "more_core_extensions"
  spec.version       = MoreCoreExtensions::VERSION
  spec.authors       = ["Jason Frey"]
  spec.email         = ["fryguy9@gmail.com"]
  spec.description   = %q{MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.}
  spec.summary       = spec.description
  spec.homepage      = "http://github.com/ManageIQ/more_core_extensions"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "activesupport", "> 3.2"
end
