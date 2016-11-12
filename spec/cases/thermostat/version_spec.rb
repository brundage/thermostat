describe Thermostat do

  let(:version) { described_class.version }
  let(:version_constant) { described_class.const_get(:VERSION) }

  it 'responds to :version' do
    expect(described_class).to respond_to :version
  end


  it "has a version" do
    expect(version).not_to be nil
  end


  it "has a version string" do
    expect(version).to be_a String
  end


  it 'has a VERSION constant' do
    expect(version_constant).not_to be nil
  end


  it 'responds with the VERSION constant' do
    expect(described_class.version).to eq(version_constant)
  end

end
