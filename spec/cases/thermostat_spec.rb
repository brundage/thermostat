describe Thermostat do

  shared_examples_for 'a configured thermostat' do

    it 'has a default config' do
      expect( subject.default_config ).to eq expected_config
    end


    it 'the default config is a Thermostat::Config' do
      expect( subject.default_config ).to be_a(described_class.const_get(:Config))
    end

  end


  it 'has a class-level logger' do
    expect(described_class.logger).to be_a Brogger
  end


  it 'allows you to change the class-level logger' do
    described_class.logger = :llama
    expect(described_class.logger).to eq :llama
  end


  context 'default configuration' do
    let(:expected_config) { Thermostat::ConfigLoader.new(filename: filename).read }

    context 'with no config arugment' do
      let(:filename) { 'default.yml' }
      it_behaves_like 'a configured thermostat'
    end


    context 'with an alternate config' do
      let(:filename) { File.expand_path( File.join( File.dirname(__FILE__), '..', 'helpers', 'config.yml' ) ) }
      let(:subject) { described_class.new( config_file: filename ) }
      it_behaves_like 'a configured thermostat'
    end

  end

end
