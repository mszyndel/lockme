# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lockme/version'

Gem::Specification.new do |spec|
  spec.name          = "lockme"
  spec.version       = Lockme::VERSION
  spec.authors       = ["Mike Szyndel"]
  spec.email         = ["mike@szyndel.com"]

  spec.summary       = "lockme.pl API client library"
  spec.homepage      = "https://github.com/hajder/lockme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "simplecov"
  spec.add_dependency "httparty", "~> 0.15.6"
end
