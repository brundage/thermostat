module Thermostat::HardwareController::RaspberryPi
  class Relay < Thermostat::HardwareController::Relay

    include Thermostat::HardwareController::RaspberryPi

    attr_reader :pin, :open_direction

    def initialize(pin, numbering: :bcm, open_direction: :low)
      self.pin = pin
      self.open_direction = open_direction
      set_numbering numbering if numbering
      initialize_pin pin, as: :output, initialize: opposite(open_direction)
    end


    def close
      super
      gpio.send "set_#{close_direction}", pin
    end


    def open
      super
      gpio.send :cleanup_pin, pin
    end


  private

    attr_writer :pin, :open_direction

    def close_direction
      opposite open_direction
    end

  end
end
