describe Thermostat::HeatPump do

  context 'initialization' do
    let(:controller_object) { subject.send(:controller) }
    let(:state_machine_type) { described_class.const_get(:StateMachine) }
    let(:state_machine) { subject.send(:state_machine) }
    let(:state_machine_object) { state_machine.instance_variable_get(:@object) }
    let(:subject) { described_class.new controller: controller }

    context  'with a nil controller' do
      let(:controller) { nil }

      it 'throws an argument error' do
        expect{ described_class.new controller: controller }.to raise_error(ArgumentError)
      end

    end


    context 'with a controller' do
      let(:controller) { :c }

      it 'starts with a state machine assigned to itself' do
        expect(state_machine_object).to eq subject
      end


      it 'starts with a heat pump state machine' do
        expect(state_machine).to be_a(state_machine_type)
      end


      it 'has a controller' do
        expect(controller_object).not_to be_nil
      end

    end

  end
end
