describe Thermostat do

  it 'has a set_point reader' do
    expect(subject).to respond_to(:set_point)
  end


  it 'has a set_point writer' do
    expect(subject).to respond_to(:set_point=)
  end


  it 'has a private state_machine reader' do
    expect(subject.private_methods).to include(:state_machine)
  end


  it 'does not has a private state_machine writer' do
    expect(subject.private_methods).to include(:state_machine=)
  end


  it 'throws an error when setting the temperature to a non-number' do
    expect { subject.set_point = nil }.to raise_error(Thermostat::InvalidSetpoint)
  end

end
