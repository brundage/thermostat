describe Thermostat::Config do
  it 'cooldown_seconds defaults to 120' do
    expect(subject[:cooldown_seconds]).to eq 120
  end


  it 'initial_set_point defaults to nil' do
    expect(subject[:initial_set_point]).to eq nil
  end


  it 'max_set_point defaults to 26.7' do
    expect(subject[:max_set_point]).to eq 26.7
  end


  it 'min_set_point defaults to 18.3' do
    expect(subject[:min_set_point]).to eq 18.3
  end


  context 'overriding defaults' do
    let(:args) { { cooldown_seconds: cooldown_seconds,
                   initial_set_point: initial_set_point,
                   max_set_point: max_set_point,
                   min_set_point: min_set_point,
               } }
    let(:subject) { described_class.new args }
    let(:cooldown_seconds) { 40000 }
    let(:initial_set_point) { -1 }
    let(:max_set_point) { 4 }
    let(:min_set_point) { 5 }


    [ :cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point ].each do |k|
      it "overrides #{k}" do
        expect(subject.send(k)).to eq(send(k))
      end
    end

  end

end
