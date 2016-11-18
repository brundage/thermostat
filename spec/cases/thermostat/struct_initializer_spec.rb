class Llama < Struct.new(:length)
  include Thermostat::StructInitializer
  def self.default_length; 1; end
end
describe Thermostat::StructInitializer do

  let(:default_length) { Llama.default_length }
  let(:subject) { Llama.new length }

  context 'when not initialized' do
    let(:length) { nil }
    it 'has a default length' do
      expect( subject.length ).to eq(default_length)
    end
  end


  context 'when initialized' do
    let(:length) { 2 }
    it 'overrides the default length' do
      expect( subject.length ).to eq(length)
    end
  end

end
