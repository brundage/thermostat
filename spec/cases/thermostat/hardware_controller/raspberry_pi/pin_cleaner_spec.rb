describe Thermostat::HardwareController::RaspberryPi::PinCleaner do

  let(:klass) { Class.new { include Thermostat::HardwareController::RaspberryPi::PinCleaner } }
  let(:pin) { 1 }
  let(:subject) { klass.new }


  before do
#    allow_any_instance_of(RPi::GPIO).to receive(:set_numbering)
    allow(RPi::GPIO).to receive(:clean_up)
  end


  it 'clean_up returns a proc' do
    expect(subject.clean_up(pin)).to be_a Proc
  end


  it 'sends clean_up to the gpio' do
    subject.clean_up(pin).call
    expect( RPi::GPIO ).to have_received(:clean_up).with(pin)
  end

end
