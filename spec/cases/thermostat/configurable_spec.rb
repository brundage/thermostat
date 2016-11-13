describe Thermostat::Configurable do

  let(:configurable) do
    $thing = described_class
    class Blark
      extend $thing
    end
  end

  it 'has a configure method' do
    expect(configurable).to respond_to(:configure)
  end


  it 'has a config method' do
    expect(configurable).to respond_to(:config)
  end


  context 'configuring things' do
    let(:method) { :initial_set_point }
    let(:value) { 5 }

    it 'can configure via a block' do
      expect(configurable.config.send(method)).not_to eq(value)
      configurable.configure do |c|
        c.send "#{method}=", value
      end
      expect(configurable.config.send(method)).to eq(value)
    end
    
  end

end
