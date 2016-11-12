require 'statesman'
class Thermostat
  class StateMachine
    include Statesman::Machine

    state :idle, initial: true
    state :cooldown
    state :running

    transition from: :idle, to: :running
    transition from: :running, to: :cooldown
    transition from: :cooldown, to: :idle

    guard_transition(from: :cooldown, to: :idle) do |thermostat|
      thermostat.idle_allowed?
    end

  end
end
