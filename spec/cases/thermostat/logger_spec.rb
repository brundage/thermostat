describe Thermostat::Logger do

  let(:klass) { Class.new { include Thermostat::Logger } }
  let(:logger) { subject.logger }
  let(:subject) { klass.new }

  it 'has a logger' do
    expect(logger).not_to be_nil
  end


  it 'has a logger writer' do
    expect(subject).to respond_to :logger=
  end


  it 'uses Therrmostat#logger' do
    expect(logger).to eq Thermostat.logger
  end

end
