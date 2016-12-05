require 'coveralls'
Coveralls.wear!
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "thermostat"
Thermostat.logger.level = :unknown
Thermostat.logger.subsystem = :quiet
