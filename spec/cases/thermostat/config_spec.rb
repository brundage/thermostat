describe Thermostat::Config do

  it 'cooldown_seconds defaults to 120' do
    expect(subject.cooldown_seconds).to eq 120
  end


  it 'initial_set_point defaults to 23.9' do
    expect(subject.initial_set_point).to eq 23.9
  end


  it 'max_set_point defaults to 26.7' do
    expect(subject.max_set_point).to eq 26.7
  end


  it 'min_set_point defaults to 18.3' do
    expect(subject.min_set_point).to eq 18.3
  end


  [ :cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point ].each do |i|

    it "has a #{i} reader" do
      expect(subject).to respond_to(i)
    end


    it "has a #{i} writer" do
      expect(subject).to respond_to("#{i}=")
    end

  end

end
