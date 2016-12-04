require 'brogger'
require "thermostat/version"

class Thermostat

  autoload :Config,              File.join('thermostat', 'config')
  autoload :ConfigLoader,        File.join('thermostat', 'config_loader')
  autoload :Controller,          File.join('thermostat', 'controller')
  autoload :Fan,                 File.join('thermostat', 'fan')
  autoload :HardwareController,  File.join('thermostat', 'hardware_controller')
  autoload :HeatIndexCalculator, File.join('thermostat', 'heat_index_calculator')
  autoload :InvalidSetpoint,     File.join('thermostat', 'invalid_setpoint')
  autoload :Logger,              File.join('thermostat', 'logger')
  autoload :LoggingAdapter,      File.join('thermostat', 'logging_adapter')
  autoload :Sensor,              File.join('thermostat', 'sensor')
  autoload :Simple,              File.join('thermostat', 'simple')
  autoload :StateMachineQuestions,  File.join('thermostat', 'state_machine_questions')
  autoload :StructInitializer,   File.join('thermostat', 'struct_initializer')
  autoload :Zone,                File.join('thermostat', 'zone')

  extend Logger

  attr_reader :default_config


  def initialize(config_file: 'default.yml')
    @default_config = ConfigLoader.new(filename: config_file).read
  end


  def logger; self.class.logger; end


  def outside_sensor
  end

end
