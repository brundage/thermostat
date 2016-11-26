require 'statesman'
class Thermostat
  module StateMachineLogger
    # Logging module for Statesman

    def self.extended(mod)

      mod.before_transition do |thing, transition|
        thing.logger.debug "#{thing} beginning transition to #{transition.to_state}"
      end

      mod.after_transition do |thing, transition|
        thing.logger.debug "#{thing} inished transition to #{transition.to_state}"
      end

    end

  end
end
