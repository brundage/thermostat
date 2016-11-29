require 'rpi_gpio'
module Thermostat::HardwareController::RaspberryPi
  module PinCleaner

    def clean_up(pin,numbering=:bcm)
      proc {
        RPi::GPIO.set_numbering numbering
        RPi::GPIO.clean_up pin
     }
    end

  end
end
