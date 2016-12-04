class Thermostat
  class Simple < Controller
    # Basic 4 and 5-wire thermostats

    autoload :StateMachine, File.join('thermostat', 'simple', 'state_machine')

    attr_accessor :name

    def initialize(cooling_controller: nil, fanning_controller: nil, heating_controller: nil,  name: nil)
      self.name = name
      self.cooling_controller = cooling_controller
      self.fanning_controller = fanning_controller
      self.heating_controller = heating_controller
      self.state_machine = StateMachine.new self
    end



    def cool; switch_to :cooling; end
    def cooldown; switch_to :cooldown; end
    def heat; switch_to :heating; end
    def off; switch_to :idle; end


    def cooldown_passed?; true; end


    def toggle(switch)
      case switch
      when :cooldown
        fanning_controller.on
        cooling_controller.off
        heating_controller.off
      when :cooling
        fanning_controller.on
        cooling_controller.on
        heating_controller.off
      when :heating
        fanning_controller.on
        cooling_controller.off
        heating_controller.on
      when :idle
        fanning_controller.off
        cooling_controller.off
        heating_controller.off
      else
        logger.debug(self.class.name) { "Don't know how to toggle #{switch} to #{state}" }
      end
    end

  private

    attr_accessor :cooling_controller, :fanning_controller, :heating_controller, :state_machine

  end
end
