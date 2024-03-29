# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thermostat/version'

Gem::Specification.new do |spec|
  spec.name        = "thermostat"
  spec.version     = Thermostat.version
  spec.authors     = ["Dean Brundage"]
  spec.email       = ["github@deanandadie.net"]

  spec.summary     = %q{A thermostat gem}
  spec.description = %q{For controlling a thermostat}
  spec.homepage    = "https://github.com/brundage/thermostat"
  spec.license     = 'AGPL-3.0'

  spec.required_ruby_version = '>= 2.1'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^spec/cases})
  end

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"

  spec.add_runtime_dependency 'barometer'
  spec.add_runtime_dependency 'ruby_i2c'
  spec.add_runtime_dependency 'ruby-units'
  spec.add_runtime_dependency 'rpi_gpio'
  spec.add_runtime_dependency 'statesman'

end
