class CoolThermostat
  def idle_allowed?; true; end
end


class HotThermostat
  def idle_allowed?; false; end
end


def force_state_change(machine, state)
  machine.instance_variable_get(:@storage_adapter).create(nil, state)
end


describe Thermostat::StateMachine do

  let(:machine) { described_class.new thermostat}
  let(:thermostat) { nil }

  it 'starts idle' do
    expect( machine.current_state.intern ).to eq :idle
  end


  context 'idling' do

    it 'can transition to running' do
      expect( machine.can_transition_to?(:running)).to eq(true)
    end


    it 'can not transition to cooldown' do
      expect( machine.can_transition_to?(:cooldown)).to eq(false)
    end

  end


  context 'running' do

    it 'can transition to cooldown' do
      force_state_change(machine, :running)
      expect( machine.can_transition_to?(:cooldown)).to eq(true)
    end


    it 'can not transition to idle' do
      force_state_change(machine, :running)
      expect( machine.can_transition_to?(:idle)).to eq(false)
    end

  end


  context 'cooldown' do

    context 'when the thermostat allows idle transition' do
      let(:thermostat) { CoolThermostat.new }
      it 'can transition to idle' do
        force_state_change(machine, :cooldown)
        expect( machine.can_transition_to?(:idle)).to eq(true)
      end
    end


    context 'when the thermostat does not allow idle transition' do
      let(:thermostat) { HotThermostat.new }
      it 'can not transition to idle' do
        force_state_change(machine, :cooldown)
        expect( machine.can_transition_to?(:idle)).to eq(false)
      end
    end


    it 'can not transition to running' do
      force_state_change(machine, :cooldown)
      expect( machine.can_transition_to?(:running)).to eq(false)
    end

  end

end
