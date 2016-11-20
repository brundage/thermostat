describe Thermostat::HardwareController::Relay do

  it 'has a #close method' do
    expect(subject).to respond_to(:close)
  end


  it 'has a #open method' do
    expect(subject).to respond_to(:open)
  end

end
