class Thermostat
  class HardwareController

    autoload :RaspberryPi, File.join('thermostat', 'hardware_controller', 'raspberry_pi')
    autoload :Relay, File.join('thermostat', 'hardware_controller', 'relay')

  end
end
