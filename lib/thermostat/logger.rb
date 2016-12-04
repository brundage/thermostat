require 'logger'
class Thermostat
  class Logger < ::Logger

    autoload :Formatter, File.join('thermostat', 'logger', 'formatter')

    module Subsystem
      HARDWARE      = 0  # Raspberry Pi / microcontroller information
      STATE_MACHINE = 1  # State changes
      CONTROLLER    = 2  # Hardware controller messages
      SENSOR        = 3  # Temperature, humidity, etc
      THERMOSTAT    = 4  # General operation messages
    end
    include Subsystem

    # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    SEVERITY_MAPPING = { debug: DEBUG,     # Low-level information for developers
                         error: ERROR,     # A handleable error condition
                         fatal: FATAL,     # An unhandleable error that results in a program crash
                         info: INFO,       # Generic (useful) information about system operation
                         unknown: UNKNOWN, # An unknown message that should always be logged
                         warn: WARN        # A warning
                       }

    # HARDWARE < STATE_MACHINE < CONTROLLER < SENSOR < THERMOSTAT
    SUBSYSTEM_MAPPING = { controller:    CONTROLLER,
                          hartware:      HARDWARE,
                          thermostat:    THERMOSTAT,
                          sensor:        SENSOR,
                          state_machine: STATE_MACHINE
                        }

    attr_reader :subsystem

    def add(severity, subsystem, message=nil)
      severity = lookup_severity(severity)
      subsystem = lookup_subsystem(subsystem)
      if @logdev.nil? or (severity < @level and subsystem < @subsystem)
        return true
      end
      if message.nil? && block_given?
        message = yield
      end
      if message.nil?
        false
      else
        @logdev.write format_message(format_severity(severity), format_subsystem(subsystem), Time.now, message )
        true
      end
    end


    def controller(severity=nil, msg=nil, &block)
      add severity, CONTROLLER, msg, &block
    end


    def debug(subsystem=nil, msg=nil, &block)
      add DEBUG, subsystem, msg, &block
    end


    def error(subsystem=nil, msg=nil, &block)
      add ERROR, subsystem, msg, &block
    end


    def fatal(subsystem=nil, msg=nil, &block)
      add FATAL, subsystem, msg, &block
    end


    def format_message(severity, subsystem, time, message)
      @formatter.call(severity, subsystem, time, @progname, message)
    end



    def hardware(severity=nil, msg=nil, &block)
      add severity, HARDWARE, msg, &block
    end 


    def info(subsystem=nil, msg=nil, &block)
      add INFO, subsystem, msg, &block
    end


    def initialize(*)
      super
      self.formatter = Formatter.new
      @subsystem = THERMOSTAT
    end


    def level=(l)
      super lookup_severity(l)
    end


    def sensor(severity=nil, msg=nil, &block)
      add severity, SENSOR, msg, &block
    end 


    def state_machine(severity=nil, msg=nil, &block)
      add severity, STATE_MACHINE, msg, &block
    end 


    def subsystem=(s)
      @subsystem = lookup_subsystem(s)
    end


    def thermostat(severity=nil, msg=nil, &block)
      add severity, THERMOSTAT, msg, &block
    end 


    def unknown(subsystem=nil, msg=nil, &block)
      add UNKNOWN, subsystem, msg, &block
    end


    def warn(subsystem=nil, msg=nil, &block)
      add WARN, subsystem, msg, &block
    end

  private

    SUBSYSTEM_LABEL = %w(HARDWARE STATE_MACHINE CONTROLLER SENSOR THERMOSTAT ANY).each(&:freeze).freeze

    def severity_mapping; SEVERITY_MAPPING; end
    def subsystem_mapping; SUBSYSTEM_MAPPING; end


    def format_subsystem(s)
      SUBSYSTEM_LABEL[s] || SUBSYSTEM_LEVEL[-1]
    end


    def lookup_severity(s)
      lookup(s, severity_mapping, UNKNOWN)
    end


    def lookup_subsystem(s)
      lookup(s, subsystem_mapping, THERMOSTAT)
    end


    def lookup(s,m,d)
      s.is_a?(Integer) ? s : m.fetch(s.to_s.downcase.intern, d)
    end

  end
end
