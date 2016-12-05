class Thermostat
  module Logging

    # TODO Implement multi-logger
    # http://stackoverflow.com/a/6410202
    def self.default_logger(level: :warn, subsystem: :thermostat)
      Thermostat::Logger.new(STDERR).tap do |logger|
        logger.level = level
        logger.progname = :rubostat
        logger.subsystem = subsystem
      end
    end


    def logger
      @logger ||= if self == Thermostat
                    Thermostat::Logging.default_logger
                  else
                    Thermostat.logger
                  end
    end

  end
end
