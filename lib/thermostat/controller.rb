class Thermostat
  class Controller
    include Thermostat::Logger

  private

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
