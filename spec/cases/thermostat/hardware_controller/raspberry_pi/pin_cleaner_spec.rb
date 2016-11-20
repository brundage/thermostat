describe Thermostat::HardwareController::RaspberryPi::PinCleaner do

  let(:klass) { Class.new { include Thermostat::HardwareController::RaspberryPi::PinCleaner } }
  let(:pin) { 1 }
  let(:subject) { klass.new }

  it 'clean_up returns a proc' do
    expect(subject.clean_up(pin)).to be_a Proc
  end

end
