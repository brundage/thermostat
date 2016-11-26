class Thermostat
  module Logger

    attr_writer :logger

    # TODO Implement multi-logger
    # http://stackoverflow.com/questions/6407141/how-can-i-have-ruby-logger-log-output-to-stdout-as-well-as-file
    def default_logger(level: :warn)
      Brogger.new(STDERR).tap do |logger|
        logger.level = level
        logger.progname = :thermostat
      end
    end


    def logger
      @logger ||= default_logger
    end

  end
end
