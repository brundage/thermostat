describe Thermostat::Logger do

  let(:logdev) { $stdout }
  let(:subject) { described_class.new logdev }

  context 'changing levels with a symbol' do

    described_class.const_get(:SEVERITY_MAPPING).each_pair do |sym, level|
      it "changes level to #{sym}" do
        expect(subject.level).not_to eq sym
        subject.level = sym
        expect(subject.level).to eq level
      end
    end

    it 'uses UNKNOWN when the symbol is unrecognized' do
      sym = :blark
      expect(described_class.const_get(:SEVERITY_MAPPING).has_key?(sym)).to be_falsey
      subject.level = sym
      expect( subject.level).to eq described_class.const_get(:UNKNOWN)
    end

  end


  context 'changing subsystems with a symbol' do

    described_class.const_get(:SUBSYSTEM_MAPPING).each_pair do |sym, level|
      it "changes subsystem to #{sym}" do
        expect(subject.subsystem).not_to eq sym
        subject.subsystem = sym
        expect(subject.subsystem).to eq level
      end
    end

    it 'uses NONE when the symbol is unrecognized' do
      sym = :blark
      expect(described_class.const_get(:SUBSYSTEM_MAPPING).has_key?(sym)).to be_falsey
      subject.subsystem = sym
      expect( subject.subsystem).to eq described_class.const_get(:NONE)
    end

  end 

end
