describe Thermostat::FanController do


  context 'initialization' do
    let(:state_machine) { subject.send(:state_machine) }
    let(:state_machine_object) { state_machine.instance_variable_get(:@object) }

    it 'starts with a state machine assigned to itself' do
      expect(state_machine_object).to eq subject
    end

  end

end
