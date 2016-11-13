require "thermostat/version"

class Thermostat

  autoload :Config, File.join('thermostat', 'config')
  autoload :Configurable, File.join('thermostat', 'configurable')
  autoload :InvalidSetpoint, File.join('thermostat', 'invalid_setpoint')
  autoload :StateMachine, File.join('thermostat', 'state_machine')

  extend Configurable

  attr_accessor :cooldown_seconds
  attr_reader :set_point


  def initialize
  end


  def set_point=(temp)
    raise InvalidSetpoint unless(temp.is_a?(Numeric))
    @set_point = temp
  end


  private

    attr_accessor :state_machine

end
