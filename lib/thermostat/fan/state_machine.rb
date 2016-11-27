require 'statesman'
class Thermostat
  class Fan
    class StateMachine
      include Statesman::Machine
      extend Thermostat::StateMachineLogger

      state :idle, initial: true
      state :running

      include Thermostat::StateMachineQuestions  # Must have this after #state calls

      transition from: :idle,    to: :running
      transition from: :running, to: :idle

      after_transition(to: :idle) do |controller|
        controller.off
      end


      after_transition(to: :running) do |controller|
        controller.on
      end

    end
  end
end
