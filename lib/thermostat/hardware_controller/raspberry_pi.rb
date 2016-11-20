require 'rpi_gpio'

class Thermostat
  class HardwareController
    module RaspberryPi

      autoload :PinCleaner, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'pin_cleaner')
      autoload :Relay, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'relay')
      autoload :Thermometer, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'thermometer')

      def clean_up(pin)
        gpio.clean_up pin
      end


      def initialize_pin(pin, **args)
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

    private

      def gpio
        RPi::GPIO
      end

    end
  end
end
