describe Thermostat::Logging do

  context 'class-level logger' do
    let(:logger) { described_class.default_logger }

    it 'has a default_logger' do
      expect(logger).not_to be_nil
    end

    it 'is a Brogger' do
      expect(logger).to be_a Thermostat::Logger
    end

  end


  let(:klass) { Class.new { include Thermostat::Logging } }
  let(:logger) { subject.logger }
  let(:subject) { klass.new }

  it 'has a logger' do
    expect(logger).not_to be_nil
  end


  it 'uses Therrmostat#logger' do
    expect(logger).to eq Thermostat.logger
  end

end
