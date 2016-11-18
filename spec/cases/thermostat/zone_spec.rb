RSpec::Expectations.configuration.on_potential_false_positives = :nothing

describe Thermostat::Zone do

  shared_context 'bad set points' do
    it 'blows up' do
      expect{ subject.set_point = set_point }.to raise_error(Thermostat::InvalidSetpoint)
    end
  end

  shared_context 'good set point' do
    it 'sets the set point' do
      subject.set_point = set_point
      expect(subject.set_point).to eq(set_point)
    end
  end


  let(:subject) { described_class.new thermostat: thermostat }

  context 'with a nil thermostat' do
    let(:thermostat) { nil }
    it 'explodes on initialization' do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end


  context 'with a thermostat' do
    let(:thermostat) { Thermostat.new }
    let(:config) { thermostat.default_config }

    it 'initializes correctly' do
      expect{ subject }.not_to raise_error(ArgumentError)
    end


    it 'has the given thermostat' do
      expect(subject.thermostat).to eq(thermostat)
    end


    it 'has one heat pump' do
      expect( subject.heat_pump ).to be_a(Thermostat::HeatPump)
    end


    it 'has one fan' do
      expect( subject.fan ).to be_a(Thermostat::Fan)
    end


    it 'has a sensor array' do
      expect( subject.sensors ).to be_an(Array)
    end


    it 'has an outdoor sensor' do
      expect( subject.outside_sensor ).to be_an(Thermostat::Sensor)
    end


    it 'has a set point initialized to nil' do
      expect(subject.set_point).to be_nil
    end


    it 'has a default config equal to the thermostat config' do
      expect(subject.config).to eq thermostat.default_config
    end

    it 'has a maximum set point' do
      expect(subject.max_set_point).to eq config.max_set_point
    end


    it 'has a minimum set point' do
      expect(subject.min_set_point).to eq config.min_set_point
    end

    describe 'changing set point' do

      context 'with a nil set point' do
        let(:set_point) { nil }
        it_behaves_like 'good set point'
      end


      context 'with a valid set point' do
        let(:set_point) { thermostat.default_config.max_set_point - 1 }
        it_behaves_like 'good set point'
      end


      context 'with a string set point' do
        let(:set_point) { "" }
        it_behaves_like 'bad set points'
      end


      context 'with a set point above the maximum' do
        let(:set_point) { thermostat.default_config.max_set_point + 1 }

        it_behaves_like 'bad set points'
      end

    end

  end

end
