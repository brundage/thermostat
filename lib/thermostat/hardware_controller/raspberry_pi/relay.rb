module Thermostat::HardwareController::RaspberryPi
  class Relay

    extend Thermostat::HardwareController::RaspberryPi::PinCleaner
    include Thermostat::Logger
    include Thermostat::HardwareController::RaspberryPi

    attr_reader :pin, :close_direction

    def initialize(pin, numbering: :bcm, close_direction: :low)
      logger.debug(self.class.name) { "Setting up relay on pin #{pin} (numbering: #{numbering}, close_direction: #{close_direction})" }
      self.pin = pin
      self.close_direction = close_direction
      set_numbering numbering if numbering
      initialize_pin pin, as: :output, initialize: opposite(close_direction)
      ObjectSpace.define_finalizer( self, self.class.clean_up(pin) )
    end


    def close
      logger.debug(self.class.name) { "sending gpio set_#{close_direction} on #{pin}" }
      gpio.send "set_#{close_direction}", pin
    end
    alias_method :on, :close


    def open
      logger.debug(self.class.name) { "sending gpio clean_up #{pin}" }
      gpio.send "set_#{open_direction}", pin
    end
    alias_method :off, :open


  private

    attr_writer :pin, :close_direction

    def open_direction
      opposite close_direction
    end

  end
end
