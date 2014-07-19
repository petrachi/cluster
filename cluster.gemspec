# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cluster/version'

Gem::Specification.new do |spec|
  spec.name          = "cluster"
  spec.version       = Cluster::VERSION
  spec.authors       = ["Thomas Petrachi"]
  spec.email         = ["thomas.petrachi@vodeclic.com"]
  spec.description   = %q{Commons for space}
  spec.summary       = %q{Commons for space}
  spec.homepage      = "https://github.com/petrachi/cluster"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'better_errors', '~> 1.1.0'
  spec.add_runtime_dependency 'binding_of_caller', '~> 0.7.2'
  spec.add_runtime_dependency 'compass-rails', '~> 2.0.0'
  spec.add_runtime_dependency 'font-awesome-rails', '~> 4.1.0.0'
  spec.add_runtime_dependency 'pry', '~> 0.10.0'
  spec.add_runtime_dependency 'slim', '~> 2.0.2'
end
