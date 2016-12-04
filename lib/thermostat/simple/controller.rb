class Thermostat::Simple
  class Controller
    include Thermostat::Logging

    attr_accessor :state_machine

    def initialize(cool_relay:, fan_relay:, heat_relay:, cooldown_seconds: 120)
      self.cool_relay = cool_relay 
      self.fan_relay = fan_relay
      self.heat_relay = heat_relay
      self.cooldown_seconds = cooldown_seconds
    end


    def cooldown_passed?
      if cooldown_enter_time
        (Time.now - cooldown_enter_time) > cooldown_seconds
      else
        true
      end
    end


    def toggle(switch)
      case switch
      when :cooldown
        fan_relay.on
        cool_relay.off
        heat_relay.off
      when :cooling
        fan_relay.on
        cool_relay.on
        heat_relay.off
      when :fanning
        fan_relay.on
        cool_relay.off
        heat_relay.off
      when :heating
        fan_relay.on
        cool_relay.off
        heat_relay.on
      when :idle
        fan_relay.off
        cool_relay.off
        heat_relay.off
      else
        logger.controller(:error) { "Don't know how to toggle #{switch} to #{state}" }
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


  end
end
