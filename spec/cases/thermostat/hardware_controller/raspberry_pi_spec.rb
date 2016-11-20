describe Thermostat::HardwareController::RaspberryPi do

  let(:klass) { Class.new { include Thermostat::HardwareController::RaspberryPi } }
  let(:subject) { klass.new }
  let(:gpio) { double :gpio,
                      clean_up: nil,
                      setup: nil,
                      set_numbering: nil
             }

  before do
    allow(subject).to receive(:gpio).and_return(gpio)
  end


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


  describe 'setting up numbering' do
    let(:numbering) { :bcm }

    before do
      subject.set_numbering numbering
    end

    it 'passes #set_numbering along to the gpio' do
      expect(gpio).to have_received(:set_numbering).with(numbering)
    end

  end


  describe 'initializing pins' do
    let(:init) { :high }
    let(:mode) { :output }
    let(:pin) { 1 }

    before do
      subject.initialize_pin pin, as: mode, initialize: init
    end

    it 'calls gpio#setup' do
      expect(gpio).to have_received(:setup)
    end

  end


  describe 'clean up' do
    let(:pin) { 1 }

    before do
      subject.clean_up pin
    end

    it 'passes #clean_up to the gpio' do
      expect(gpio).to have_received(:clean_up).with(pin)
    end

  end

end
