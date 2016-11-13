class Thermostat
  class HeatPump
    autoload :Controller,   File.join('thermostat', 'heat_pump', 'controller')
    autoload :StateMachine, File.join('thermostat', 'heat_pump', 'state_machine')

    def initialize
      @state_machine = StateMachine.new self
    end

  private

    attr_reader :state_machine

  end
end
