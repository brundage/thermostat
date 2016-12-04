describe Thermostat::HardwareController::RaspberryPi::Relay do

  let(:default_close_direction) { :low }
  let(:pin) { nil }
  let(:pull) { nil }

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

  shared_examples_for 'opening or closing' do
    it "sends itself the correct direction" do
      expect(subject).to have_received(pull)
    end
  end

  [ :close, :open ].each do |dir|

    describe "#{dir}ing" do
      let(:pin) { 0 }
      let(:pull) { "set_#{dir == :close ? close_direction : open_direction}" }
      let(:subject) { described_class.new pin, close_direction: close_direction }
      before do
        allow(subject).to receive(pull)
        subject.send dir
      end

      context "when pulling high to close" do
        let(:close_direction) { :high }
        let(:open_direction)  { :low }
        it_behaves_like 'opening or closing'
      end

      context "when pulling low to close" do
        let(:close_direction) { :low }
        let(:open_direction)  { :high }
        it_behaves_like 'opening or closing'
      end

    end
  end

end
