require 'brogger'
class Thermostat
  module Logger

    attr_writer :logger

    # TODO Implement multi-logger
    # http://stackoverflow.com/a/6410202
    def default_logger(level: :warn)
      Brogger.new(STDERR).tap do |logger|
        logger.level = level
        logger.progname = :thermostat
      end
    end


    def logger
      @logger ||= if self == Thermostat
                    default_logger
                  else
                    Thermostat.logger
                  end
    end

  end
end
