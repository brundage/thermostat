require 'statesman'
class Thermostat
  class LoggingAdapter < Statesman::Adapters::Memory
    include Thermostat::Logger

    def create(from, to, metadata={})
      logger.debug(@parent_model) { "Beginning transition from #{from} to #{to}" }
      t = super
      logger.debug(@parent_model) { "Finished transition from #{from} to #{to}" }
      t
    end

  end
end
