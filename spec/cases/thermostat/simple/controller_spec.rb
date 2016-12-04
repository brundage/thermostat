describe Thermostat::Simple::Controller do

  let(:cool_relay) { double :cool_relay }
  let(:fan_relay) { double :fan_relay }
  let(:heat_relay) { double :heat_relay }
  let(:subject) { described_class.new cool_relay: cool_relay, fan_relay: fan_relay, heat_relay: heat_relay }

end
