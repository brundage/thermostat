require 'statesman'
class Thermostat
  class LoggingAdapter < Statesman::Adapters::Memory
    include Thermostat::Logging

    def create(from, to, metadata={})
      logger.state_machine(:debug) { "Beginning transition from #{from} to #{to}" }
      t = super
      logger.state_machine(:debug) { "Finished transition from #{from} to #{to}" }
      t
    end

  end
end
