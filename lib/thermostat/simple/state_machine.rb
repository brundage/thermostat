require 'statesman'
class Thermostat
  class Simple
    class StateMachine
      include Statesman::Machine
      extend Thermostat::StateMachineLogger

      state :cooldown
      state :cooling
      state :fanning
      state :heating
      state :idle, initial: true
      include Thermostat::StateMachineQuestions

      transition from: :idle,     to: [ :cooling, :fanning, :heating ]
      transition from: :cooling,  to: [ :cooldown ]
      transition from: :cooldown, to: [ :cooling, :fanning, :heating, :idle ]
      transition from: :heating,  to: [ :cooldown ]

      [ :cooldown, :cooling, :heating, :idle].each do |s|
        before_transition(to: s) do |controller|
          controller.toggle s
        end
      end


      guard_transition(from: :cooldown, to: :idle) do |controller|
        controller.cooldown_passed?
      end


      guard_transition(from: :cooldown, to: :idle) do |controller|
        controller.cooldown_passed?
      end

    end
  end
end
