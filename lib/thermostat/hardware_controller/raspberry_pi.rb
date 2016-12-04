class Thermostat::HardwareController
  module RaspberryPi
    include Thermostat::Logger

    autoload :GPIO, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'gpio')
    autoload :PinCleaner, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'pin_cleaner')
    autoload :Relay, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'relay')


    def self.gpio; GPIO; end


    def self.included(mod)
      gpio.set_warnings(false)
    end


    def clean_up(pin)
      gpio.clean_up pin
    end


    def gpio
      Thermostat::HardwareController::RaspberryPi::GPIO
    end


    def initialize_pin(pin, **args)
      logger.debug(self.class.name) { "Setting pin #{pin} as #{args[:as]} initialized #{args[:initialize]}" }
      gpio.setup pin, as: args[:as], initialize: args[:initialize]
    end


    def opposite(direction)
      return :low if direction == :high
      return :high if direction == :low
      nil
    end


    def set_numbering(numbering)
      gpio.set_numbering numbering if numbering
    end

  end
end
