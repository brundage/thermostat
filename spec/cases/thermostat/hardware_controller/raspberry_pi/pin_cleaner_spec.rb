describe Thermostat::HardwareController::RaspberryPi::PinCleaner do

  let(:klass) { Class.new do
                  include Thermostat::HardwareController::RaspberryPi::PinCleaner
              end }
  let(:gpio) { double :gpio, clean_up: nil, set_numbering: nil, set_warnings: nil }
  let(:pin) { 1 }
  let(:subject) { klass.new }


  before do
    allow(Thermostat::HardwareController::RaspberryPi).to receive(:gpio).and_return(gpio)
  end

  it 'clean_up returns a proc' do
    expect(subject.clean_up(pin)).to be_a Proc
  end


  it 'sends clean_up to the gpio' do
    subject.clean_up(pin).call
    expect(gpio).to have_received(:clean_up).with(pin)
  end

end
