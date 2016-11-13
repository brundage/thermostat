require 'helpers/state_machine'

describe Thermostat::Fan::StateMachine do

  let(:controller) { nil }
  let(:machine) { described_class.new controller}

  it 'starts idle' do
    expect( machine.current_state.intern ).to eq :idle
  end


  context 'idling' do

    it "can transition to running" do
      expect( machine.can_transition_to?(:running) ).to be_truthy
    end


    it "can not transition to idle" do
      expect( machine.can_transition_to?(:idle) ).to be_falsey
    end

  end


  context 'running' do
    before do
      force_state_change(machine, :running)
    end

    it "can not transition to running" do
      expect( machine.can_transition_to?(:running) ).to be_falsey
    end


    it "can transition to idle" do
      expect( machine.can_transition_to?(:idle) ).to be_truthy
    end

  end

end
