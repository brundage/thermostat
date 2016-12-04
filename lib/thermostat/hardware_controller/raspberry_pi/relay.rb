module Thermostat::HardwareController::RaspberryPi
  class Relay

    extend Thermostat::HardwareController::RaspberryPi::PinCleaner
    include Thermostat::HardwareController::RaspberryPi

    attr_reader :pin, :close_direction

    def initialize(pin, numbering: :bcm, close_direction: :low)
      logger.debug(self.class.name) { "Setting up relay on pin #{pin} (numbering: #{numbering}, close_direction: #{close_direction})" }
      self.pin = pin
      self.close_direction = close_direction
      set_numbering numbering if numbering
      initialize_pin pin, as: :output, initialize: open_direction
      ObjectSpace.define_finalizer( self, self.class.clean_up(pin) )
    end


    def close
      toggle close_direction
    end
    alias_method :on, :close


    def open
      toggle open_direction
    end
    alias_method :off, :open


  private

    attr_writer :pin, :close_direction

    def open_direction
      opposite close_direction
    end


    def toggle(dir)
      logger.debug(self.class.name) { "sending #{dir} on pin #{pin} to the gpio" }
      gpio.send "set_#{dir}", pin
    end

  end
end
