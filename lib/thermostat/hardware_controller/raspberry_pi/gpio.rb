module Thermostat::HardwareController::RaspberryPi
  module DelegatableMethods
    def delegatable_methods 
      [ :clean_up, :rpi_gpio_loaded?, :setup, :set_high, :set_low, :set_numbering, :set_warnings ]
    end
  end

  begin
    require 'rpi_gpio'
    GPIO = ::RPi::GPIO
    GPIO.set_warnings false
    module ::RPi::GPIO
      extend DelegatableMethods
      extend self
      def rpi_gpio_loaded?; true; end
    end

  rescue RuntimeError => e
    if( e.message =~ /this gem can only be run on a Raspberry Pi/ )

      Thermostat.logger.warn(self.class.name) { "Couldn't load rpi_gpio library (#{e}) - using dummy GPIO" }

      module GPIO
        extend DelegatableMethods
        extend self

        delegatable_methods.each do |m|
          define_method(m) { |*| }
        end

        def rpi_gpio_loaded?; false; end

      end
    else
      raise e

    end
  end
end
