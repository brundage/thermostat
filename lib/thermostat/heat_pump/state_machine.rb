require 'statesman'
class Thermostat
  class HeatPump
    class StateMachine
      include Statesman::Machine

      state :cooling
      state :cooling_cooldown
      state :heating
      state :heating_cooldown
      state :idle, initial: true

      transition from: :idle,             to: [ :cooling, :heating ]
      transition from: :cooling,          to: [ :cooling_cooldown ]
      transition from: :cooling_cooldown, to: [ :cooling, :idle ]
      transition from: :heating,          to: [ :heating_cooldown ]
      transition from: :heating_cooldown, to: [ :heating, :idle ]


      guard_transition(from: :cooling_cooldown, to: :idle) do |thermostat|
        thermostat.cooling_cooldown_passed?
      end


      guard_transition(from: :heating_cooldown, to: :idle) do |thermostat|
        thermostat.heating_cooldown_passed?
      end

    end
  end
end
