describe Thermostat::HardwareController::RaspberryPi do

  let(:klass) { Class.new { include Thermostat::HardwareController::RaspberryPi } }
  let(:subject) { klass.new }

  describe 'opposites' do
    it 'opposite of :high is :low' do
      expect(subject.opposite(:high)).to eq(:low)
    end

    it 'opposite of :low is :high' do
      expect(subject.opposite(:low)).to eq(:high)
    end

    it 'oppostie of others is nil' do
      expect(subject.opposite(:blark)).to be_nil
    end
  end


  context 'forwarding to the gpio' do
    [ :clean_up, :setup, :set_numbering, :set_warnings ].each do |m|
      it "has a #{m}" do
        expect(subject).to respond_to m
      end
    end
  end

end
