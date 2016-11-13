class Thermostat
  class Fan
    autoload :Controller,   File.join('thermostat', 'fan', 'controller')
    autoload :StateMachine, File.join('thermostat', 'fan', 'state_machine')
  end
end
