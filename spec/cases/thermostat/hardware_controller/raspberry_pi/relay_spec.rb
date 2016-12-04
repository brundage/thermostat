describe Thermostat::HardwareController::RaspberryPi::Relay do

  let(:default_close_direction) { :low }
  let(:gpio) { double :gpio,
                      clean_up: nil,
                      setup: nil,
                      set_high: nil,
                      set_low: nil,
                      set_numbering: nil
             }
  let(:pin) { nil }
  let(:pull) { nil }

  before do
    allow_any_instance_of(Thermostat::HardwareController::RaspberryPi).to receive(:gpio).and_return(gpio)
  end


  context 'with no initialization' do
    it 'raises an ArgumentError' do
      expect{ described_class.new }.to raise_error(ArgumentError)
    end
  end


  context 'with a pin initialization' do

    let(:pin) { 0 }
    let(:subject) { described_class.new pin }

    context 'and a pull initiaization' do
      let(:close_direction) { :high }
      let(:subject) { described_class.new pin, close_direction: close_direction }
      it 'initializes #pull' do
        expect(close_direction).not_to eq(default_close_direction)
      end
    end

  end


  describe 'closing' do
    let(:pin) { 0 }
    let(:subject) { described_class.new pin, close_direction: close_direction }

    before do
      subject.close
    end

    context 'when pulling high to close' do
      let(:close_direction) { :high }
      it 'sends #set_high to the gpio' do
        expect(gpio).to have_received(:set_high)
      end
    end

    context 'when pulling low to close' do
      let(:close_direction) { :low }
      it 'sends #set_low to the gpio' do
        expect(gpio).to have_received(:set_low)
      end
    end
  end


  describe 'opening' do
    let(:pin) { 0 }
    let(:subject) { described_class.new pin, close_direction: close_direction }

    before do
      subject.open
    end

    context 'when pulling high to open' do
      let(:close_direction) { :high }
      it 'sends #set_low to the gpio' do
        expect(gpio).to have_received(:set_low)
      end
    end

    context 'when pulling low to open' do
      let(:close_direction) { :low }
      it 'sends #set_high to the gpio' do
        expect(gpio).to have_received(:set_high)
      end
    end

  end

end
