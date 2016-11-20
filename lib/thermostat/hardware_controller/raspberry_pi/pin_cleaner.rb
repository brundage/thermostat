require 'rpi_gpio'
module Thermostat::HardwareController::RaspberryPi
  module PinCleaner

    def clean_up(pin)
      proc { RPi::GPIO.clean_up pin }
    end

  end
end
