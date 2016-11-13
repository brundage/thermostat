class Thermostat
  class Fan
    class Controller

      def initialize
        self.state_machine = FanStateMachine.new self
      end

    private

      attr_accessor :state_machine

    end
  end
end
