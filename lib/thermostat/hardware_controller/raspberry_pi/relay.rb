module Thermostat::HardwareController::RaspberryPi
  class Relay < Thermostat::HardwareController::Relay

    extend Thermostat::HardwareController::RaspberryPi::PinCleaner
    include Thermostat::HardwareController::RaspberryPi

    attr_reader :pin, :pull

    def initialize(pin, numbering: :bcm, open_direction: :low)
      self.pin = pin
      self.pull = open_direction
      set_numbering numbering if numbering
      initialize_pin pin, as: :output, initialize: opposite(pull)
      ObjectSpace.define_finalizer( self, self.class.clean_up(pin) )
    end


    def close
      super
      gpio.send "set_#{close_direction}", pin
    end


    def open
      super
      gpio.send "set_#{open_direction}", pin
    end


  private

    attr_writer :pin, :pull

    def close_direction
      opposite open_direction
    end


    def open_direction
      pull
    end

  end
end
