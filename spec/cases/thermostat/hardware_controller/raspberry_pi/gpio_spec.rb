describe Thermostat::HardwareController::RaspberryPi::GPIO do

  let(:subject) { described_class }

  described_class.delegatable_methods.each do |m|
    it "has a #{m} method" do
      expect(subject).to respond_to(m)
    end
  end

  context 'testing if the real library was loaded' do
    let(:result) { subject.rpi_gpio_loaded? ? :be_truthy : :be_falsey }
    it "if the library #{described_class.rpi_gpio_loaded? ? "was" : "wasn't"} loaded, #rpi_gpio_loaded? should #{described_class.rpi_gpio_loaded? ? :be_truthy : :be_falsey}" do
      expect(subject.rpi_gpio_loaded?).to send(result)
    end
  end

end
