class Thermostat::Logger
  class Formatter < ::Logger::Formatter

    def call(severity, subsystem, time, progname, msg)
      format % [ time.utc.iso8601, progname, $$, subsystem, severity, msg2str(msg) ]
    end


    def format
      # time [progname.pid] subsystem.severity: msg
      "%s [%s.%d] %13s.%-5s %s\n"
    end


    def msg2str(*)
      super.strip
    end

  end
end
