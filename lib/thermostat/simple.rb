class Thermostat
  class Simple
    # Basic 4 and 5-wire thermostats
    include Thermostat::Logging

    autoload :Controller, File.join('thermostat', 'simple', 'controller')
    autoload :StateMachine, File.join('thermostat', 'simple', 'state_machine')

    attr_accessor :name
    attr_reader :controller, :state_machine

    def initialize(controller:,  name: nil)
      self.name = name || "Simple Thermostat"
      self.controller = controller
      self.state_machine = StateMachine.new(self.controller)
      self.controller.state_machine = self.state_machine
      logger.thermostat(:info) { "Initialized simple thermostat named #{self.name}" }
    end


    def cool; switch_to :cooling; end

    def cooldown; switch_to :cooldown; end

    def heat; switch_to :heating; end

    def off; switch_to :idle; end


  private

    attr_writer :controller, :state_machine

    def switch_to(setting)
      logger.thermostat(:debug) { "Switching to #{setting}" }
      if( state_machine.can_transition_to? setting )
        state_machine.transition_to(setting)
      else
        logger.thermostat(:debug) { "State machine won't allow it" }
      end
    end

  end
end
