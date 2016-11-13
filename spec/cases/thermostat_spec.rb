describe Thermostat do

  it 'throws an error when setting the temperature to a non-number' do
    expect { subject.set_point = nil }.to raise_error(Thermostat::InvalidSetpoint)
  end


  it 'changes the set point' do
    val = 20
    expect(subject.set_point).not_to eq(val)
    subject.set_point = val
    expect(subject.set_point).to eq(val)
  end


end
