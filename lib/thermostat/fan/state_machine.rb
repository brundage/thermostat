require 'statesman'
class Thermostat
  class Fan
    class StateMachine
      include Statesman::Machine

      state :idle, initial: true
      state :running

      transition from: :idle,    to: :running
      transition from: :running, to: :idle

    end
  end
end
