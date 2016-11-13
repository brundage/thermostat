describe Thermostat::HeatPump do

  context 'initialization' do
    let(:state_machine_type) { described_class.const_get(:StateMachine) }
    let(:state_machine) { subject.send(:state_machine) }
    let(:state_machine_object) { state_machine.instance_variable_get(:@object) }

    it 'starts with a state machine assigned to itself' do
      expect(state_machine_object).to eq subject
    end


    it 'starts with a heat pump state machine' do
      expect(state_machine).to be_a(state_machine_type)
    end

  end

end
