require 'brogger'
require "thermostat/version"

class Thermostat

  autoload :Config,             File.join('thermostat', 'config')
  autoload :ConfigLoader,       File.join('thermostat', 'config_loader')
  autoload :Fan,                File.join('thermostat', 'fan')
  autoload :HeatPump,           File.join('thermostat', 'heat_pump')
  autoload :HardwareController, File.join('thermostat', 'hardware_controller')
  autoload :InvalidSetpoint,    File.join('thermostat', 'invalid_setpoint')
  autoload :Logger,             File.join('thermostat', 'logger')
  autoload :Sensor,             File.join('thermostat', 'sensor')
  autoload :StateMachineLogger, File.join('thermostat', 'state_machine_logger')
  autoload :StructInitializer,  File.join('thermostat', 'struct_initializer')
  autoload :Zone,               File.join('thermostat', 'zone')

  extend Logger

  attr_reader :default_config


  def initialize(config_file: 'default.yml')
    @default_config = ConfigLoader.new(filename: config_file).read
  end

end
