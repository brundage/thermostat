require "thermostat/version"

class Thermostat

  autoload :Config,             File.join('thermostat', 'config')
  autoload :ConfigLoader,       File.join('thermostat', 'config_loader')
  autoload :Fan,                File.join('thermostat', 'fan')
  autoload :HeatPump,           File.join('thermostat', 'heat_pump')
  autoload :HardwareController, File.join('thermostat', 'hardware_controller')
  autoload :InvalidSetpoint,    File.join('thermostat', 'invalid_setpoint')
  autoload :Sensor,             File.join('thermostat', 'sensor')
  autoload :StructInitializer,  File.join('thermostat', 'struct_initializer')
  autoload :Zone,               File.join('thermostat', 'zone')

  attr_reader :default_config

  def initialize(config_file: 'default.yml')
    @default_config = ConfigLoader.new(filename: config_file).read
  end

end
