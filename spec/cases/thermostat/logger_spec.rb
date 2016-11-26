describe Thermostat::Logger do

  let(:klass) { Class.new { include Thermostat::Logger } }
  let(:subject) { klass.new }

  it 'has a logger' do
    expect(subject.logger).not_to be_nil
  end

end
