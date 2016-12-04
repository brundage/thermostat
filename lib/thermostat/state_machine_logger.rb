require 'statesman'
class Thermostat
  module StateMachineLogger
    # Logging module for Statesman

    def self.extended(mod)

      mod.before_transition do |thing, transition|
        thing.logger.debug(thing.class.name) { "beginning transition to #{transition.to_state}" }
      end

      mod.after_transition do |thing, transition|
        thing.logger.debug(thing.class.name) { "finished transition to #{transition.to_state}" }
      end

    end

  end
end