describe Thermostat::Sensor::Temperature do

  let(:klass) { Class.new { include Thermostat::Sensor::Temperature } }
  let(:subject) { klass.new }

  shared_examples_for 'assigning a temperature' do
    it 'assigns temperature' do
      expect(subject.temperature).not_to be_nil
    end

    it 'assigns a ruby unit' do
      # kind_of? doesn't work here
      # https://github.com/olbrich/ruby-units/issues/144
      expect(subject.temperature.class).to eq RubyUnits::Unit
    end
  end 

  context 'assigning a temperature' do

    before do
      subject.send :temperature=, temp
    end

    context 'when the temp is a Numeric' do
      let(:temp) { 1 }
      it_behaves_like 'assigning a temperature'
    end

    context 'when the temp is a Unit' do
      let(:temp) { Unit.new '1 degC' }
      it_behaves_like 'assigning a temperature'
    end

  end

end
