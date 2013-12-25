# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kahuna/version'

Gem::Specification.new do |spec|
  spec.name          = "kahuna"
  spec.version       = Kahuna::VERSION
  spec.authors       = ["Brandon Dennis"]
  spec.email         = ["toady00@gmail.com"]
  spec.description   = %q{Handlers for Serf "http://serfdom.io"}
  spec.summary       = %q{Kahuna provides some nice classes for handling events fired from Serf}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "factory_girl", "~> 4.3.0"
  spec.add_development_dependency "simplecov"
end
