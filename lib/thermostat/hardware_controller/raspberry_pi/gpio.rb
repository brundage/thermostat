module Thermostat::HardwareController::RaspberryPi
  begin
    require 'rpi_gpio'
    GPIO = RPi::GPIO
  rescue RuntimeError => e
    if( e.message =~ /this gem can only be run on a Raspberry Pi/ )
      Thermostat.logger.warn(self.class.name) { "Couldn't load rpi_gpio library (#{e}) - using dummy GPIO" }
      module GPIO
        def self.clean_up(*); end
        def self.set_numbering(*); end
        def self.set_warnings(*); end
      end
    else
      raise e
    end
  end
end
