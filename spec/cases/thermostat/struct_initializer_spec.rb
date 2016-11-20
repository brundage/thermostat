describe Thermostat::StructInitializer do

  let(:default_fuzziness) { klass.default_fuzziness }
  let(:klass) { Struct.new(:fuzziness) do
                  include Thermostat::StructInitializer
                  def self.default_fuzziness; 1; end
                end
              }
  let(:subject) { klass.new fuzziness }

  context 'when not initialized' do
    let(:fuzziness) { nil }
    it 'has a default fuzziness' do
      expect( subject.fuzziness ).to eq(default_fuzziness)
    end
  end


  context 'when initialized' do
    let(:fuzziness) { 2 }
    it 'overrides the default fuzziness' do
      expect(fuzziness).not_to eq(default_fuzziness)
      expect( subject.fuzziness ).to eq(fuzziness)
    end
  end

end
