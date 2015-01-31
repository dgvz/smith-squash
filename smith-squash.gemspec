# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smith/squash/version'

Gem::Specification.new do |spec|
  spec.name          = "smith-squash"
  spec.version       = Smith::Squash::VERSION
  spec.authors       = ["Dylan Griffith"]
  spec.email         = ["dyl.griffith@gmail.com"]
  spec.summary       = %q{Integrate squash into your smith agents.}
  spec.description   = %q{Integrate squash into your smith agents.}
  spec.homepage      = "https://github.com/DylanGriffith/smith-squash"
  spec.license       = "GPL-3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "squash_ruby", "~> 2.0"
  spec.add_runtime_dependency "smith", ">= 0.6.9"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
