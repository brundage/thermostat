require 'statesman'
class Thermostat
  class Simple
    class StateMachine
      include Statesman::Machine

      state :cooldown
      state :cooling
      state :fanning
      state :heating
      state :idle, initial: true
      include Thermostat::StateMachineQuestions

      transition from: :idle,     to: [ :cooling, :fanning, :heating ]
      transition from: :cooling,  to: [ :cooldown ]
      transition from: :cooldown, to: [ :cooling, :fanning, :heating, :idle ]
      transition from: :fanning,  to: [ :idle ]
      transition from: :heating,  to: [ :cooldown ]


      def initialize(controller, options = { transition_class: Statesman::Adapters::MemoryTransition })
        super
        @storage_adapter = LoggingAdapter.new( @transition_class, controller, self, options)
      end


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
