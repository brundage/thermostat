class Thermostat
  class Simple < Controller
    # Basic 4 and 5-wire thermostats

    class Controller
      attr_accessor :c, :h
      def initialize(c, h)
        self.c = c
        self.h = h
      end
      def cool; c.on; end
      def heat; h.on; end
      def off; h.off; c.off; end
      def heating_cooldown_passed?; true; end
      def cooling_cooldown_passed?; true; end
    end

    autoload :StateMachine, File.join('thermostat', 'simple', 'state_machine')

    attr_accessor :name

    def initialize(cooling_controller: nil, heating_controller: nil,  name: nil)
      self.name = name
      self.state_machine = StateMachine.new Controller.new(cooling_controller, heating_controller)
    end



    def cool; switch_to :cooling; end
    def cooling_cooldown; switch_to :cooling_cooldown; end
    def heat; switch_to :heating; end
    def heating_cooldown; switch_to :heating_cooldown; end
    def off; switch_to :idle; end

  private

    attr_accessor :state_machine

  end
end
