class Thermostat
  class HeatPump
    autoload :Controller, File.join('thermostat', 'heat_pump', 'controller')
    autoload :StateMachine, File.join('thermostat', 'heat_pump', 'state_machine')

    def initialize(controller: nil)
      raise ArgumentError.new('no controller supplied') if controller.nil?
      self.controller = controller
      @state_machine = StateMachine.new self
    end

  private

    attr_accessor :controller
    attr_reader :state_machine

  end
end
