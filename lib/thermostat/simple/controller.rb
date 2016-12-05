class Thermostat::Simple
  class Controller
    include Thermostat::Logging

    attr_accessor :state_machine

    def initialize(cool_relay: nil, fan_relay: nil, heat_relay:, cooldown_seconds: 120, state_machine: nil)
      self.cool_relay = cool_relay 
      self.fan_relay = fan_relay
      self.heat_relay = heat_relay
      self.cooldown_seconds = cooldown_seconds
      self.state_machine = state_machine
      logger.controller(:info) { "Initialized #{wires}-wire controller with cooldown #{cooldown_seconds} seconds" }
    end


    def cooldown_passed?
      if cooldown_enter_time
        (Time.now - cooldown_enter_time) > cooldown_seconds
      else
        true
      end
    end


    def toggle(switch)
      meth = "start_#{switch}"
      if respond_to? meth, true
        logger.controller(:debug) { "Starting #{switch}" }
        send meth
      else
        logger.controller(:error) { "Don't know how to toggle to #{switch}" }
      end
    end


  private

    attr_accessor :cool_relay, :cooldown_seconds, :fan_relay, :heat_relay

    def cooldown_state
      "cooldown".freeze
    end


    def cooldown_enter_time
      state_machine.history.select { |t| t.to_state == cooldown_state }.collect(&:created_at).last
    end


    def start_cooldown
      start_stage :on, :off, :off
    end


    def start_cooling
      start_stage :on, :on, :off
    end


    def start_fanning
      start_stage :on, :off, :off
    end


    def start_heating
      start_stage :on, :off, :on
    end


    def start_idle
      start_stage :off, :off, :off
    end


    def start_stage(*states)
      fan_relay  && fan_relay.send(states[0])
      cool_relay && cool_relay.send(states[1])
      heat_relay && heat_relay.send(states[2])
    end


    def wires
      [ fan_relay, cool_relay, heat_relay ].compact.size
    end


  end
end
