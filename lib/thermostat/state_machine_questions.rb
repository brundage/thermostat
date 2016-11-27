class Thermostat
  module StateMachineQuestions

    def self.included(mod)
      mod.states.each do |state|
        unless mod.method_defined? state.intern
          mod.module_eval %Q-
            def #{state}?
              current_state == "#{state}"
            end 
          -
        end
      end
    end

  end
end
