class Thermostat
  class Simple
    # Basic 4 and 5-wire thermostats
    include Thermostat::Logger

    autoload :StateMachine, File.join('thermostat', 'simple', 'state_machine')

    attr_accessor :name

    def initialize(cooling_controller: nil, fanning_controller: nil, heating_controller: nil,  name: nil)
      self.name = name
      self.cooling_controller = cooling_controller
      self.fanning_controller = fanning_controller
      self.heating_controller = heating_controller
      self.state_machine = StateMachine.new self
    end



    def cool; switch_to :cooling; end
    def cooldown; switch_to :cooldown; end
    def heat; switch_to :heating; end
    def off; switch_to :idle; end


    def cooldown_passed?
      true
    end


    def toggle(switch)
      case switch
      when :cooldown
        fanning_controller.on
        cooling_controller.off
        heating_controller.off
      when :cooling
        fanning_controller.on
        cooling_controller.on
        heating_controller.off
      when :heating
        fanning_controller.on
        cooling_controller.off
        heating_controller.on
      when :idle
        fanning_controller.off
        cooling_controller.off
        heating_controller.off
      else
        logger.error(self.class.name) { "Don't know how to toggle #{switch} to #{state}" }
      end
    end

  private

    attr_accessor :cooling_controller, :fanning_controller, :heating_controller, :state_machine

    def switch_to(setting)
      logger.debug(self.class.name) { "Switching to #{setting}" }
      if( state_machine.can_transition_to? setting )
        state_machine.transition_to(setting)
      else
        logger.debug(self.class.name) { "State machine won't allow it" }
      end
    end

  end
end
