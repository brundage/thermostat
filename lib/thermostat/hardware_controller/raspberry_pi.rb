class Thermostat::HardwareController
  module RaspberryPi
    extend Forwardable
    include Thermostat::Logger

    autoload :GPIO, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'gpio')
    autoload :PinCleaner, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'pin_cleaner')
    autoload :Relay, File.join('thermostat', 'hardware_controller', 'raspberry_pi', 'relay')

    def_delegators :GPIO, *GPIO.delegatable_methods


    def initialize_pin(pin, **args)
      logger.debug(self.class.name) { "Setting pin #{pin} as #{args[:as]} initialized #{args[:initialize]}" }
      setup pin, as: args[:as], initialize: args[:initialize]
    end


    def opposite(direction)
      return :low if direction == :high
      return :high if direction == :low
      nil
    end

  end
end
