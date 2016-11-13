require "thermostat/version"

class Thermostat

  autoload :Config,          File.join('thermostat', 'config')
  autoload :Fan,             File.join('thermostat', 'fan')
  autoload :HeatPump,        File.join('thermostat', 'heat_pump')
  autoload :InvalidSetpoint, File.join('thermostat', 'invalid_setpoint')
  autoload :Sensor,          File.join('thermostat', 'sensor')
  autoload :Zone,            File.join('thermostat', 'zone')

  attr_reader :max_set_point, :min_set_point, :set_point


  def initialize(config=Config.new)
    @config = config
    @max_set_point = config[:max_set_point]
    @min_set_point = config[:min_set_point]
    self.set_point = config[:initial_set_point]
  end


  def set_point=(temp)
    raise InvalidSetpoint.new("Set point (#{temp}) is not a number") unless temp.is_a?(Numeric)
    raise InvalidSetpoint.new("Set point (#{temp})is below #{min_set_point}") if temp < min_set_point
    raise InvalidSetpoint.new("Set point (#{temp}) is above #{max_set_point}") if temp > max_set_point
    
    @set_point = temp
  end


private

  attr_reader :config

end
