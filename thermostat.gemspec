# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thermostat/version'

Gem::Specification.new do |spec|
  spec.name          = "thermostat"
  spec.version       = Thermostat.version
  spec.authors       = ["Dean Brundage"]
  spec.email         = ["github@deanandadie.net"]

  spec.summary       = %q{A thermostat gem}
  spec.description   = %q{For controlling a thermostat}
  spec.homepage      = "https://github.com/brundage/thermostat"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^spec/cases})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"

  spec.add_dependency 'statesman'
end