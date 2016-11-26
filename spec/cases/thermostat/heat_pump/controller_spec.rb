describe Thermostat::HeatPump::Controller do

  let(:klass) { Class.new { include Thermostat::HeatPump::Controller } }
  let(:subject) { klass.new }

end
