class Thermostat
  class Fan < Controller

    autoload :StateMachine, File.join('thermostat', 'fan', 'state_machine')

    def initialize(controller: nil)
      if( controller.nil? )
        m = "need a controller"
        logger.fatal(self.class.name) { m }
        raise ArgumentError.new(m)
      end
      self.controller = controller
      self.state_machine = StateMachine.new controller
    end


    def off
      switch_to :idle
    end


    def on
      switch_to :running
    end


    def toggle
      state_machine.running? ? off : on
    end

  private

    attr_accessor :controller, :state_machine

  end
end
