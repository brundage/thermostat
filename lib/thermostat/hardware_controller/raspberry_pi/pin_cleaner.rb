module Thermostat::HardwareController::RaspberryPi
  module PinCleaner

    def clean_up(pin, numbering=:bcm)
      proc {
        Thermostat.logger.hardware(:debug) { "Cleaning raspberry pi pin #{pin}" }
        Thermostat::HardwareController::RaspberryPi.gpio.set_numbering numbering
        Thermostat::HardwareController::RaspberryPi.gpio.clean_up pin
     }
    end

  end
end
