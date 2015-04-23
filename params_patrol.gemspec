# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'params_patrol/version'

Gem::Specification.new do |spec|
  spec.name          = "params_patrol"
  spec.version       = ParamsPatrol::VERSION
  spec.authors       = ["Will Bendix", "Blaine Gilbreth"]
  spec.email         = %w(wcbendix@gmail.com bgilb@seas.upenn.edu)
  spec.summary       = %q{Keeps an eye out for suspicious parameters... and then calls for backup}
  spec.description   = %q{Use whatever monitor service you would like to track strong parameter errors.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 3.0"
  spec.add_dependency "actionpack", "~> 3.0"
  spec.add_dependency "activemodel", "~> 3.0"
  spec.add_dependency "railties", "~> 3.0"
  spec.add_dependency "strong_parameters"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mocha"
end
