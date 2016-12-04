require 'helpers/state_machine'

describe Thermostat::Simple::StateMachine do

  let(:cool_thermostat_class) { Class.new do
    def cooldown_passed?; true; end
    def toggle(*); end
  end }

  let(:hot_thermostat_class) { Class.new do
    def cooldown_passed?; false; end
    def toggle(*); end
  end }

  shared_examples_for 'a running thermostat' do
    [ :idle, :cooling, :heating ].each do |s|
      it "can not transition to #{s}" do
        expect( machine.can_transition_to?(s)).to eq(false)
      end
    end
    it 'can transition to cooldown' do
      expect( machine.can_transition_to?(:cooldown)).to eq(true)
    end
  end


  shared_examples_for 'a cooldown thermostat' do
    before do
      force_state_change(machine, state)
    end

    it 'can go back' do
      expect( machine.can_transition_to?(previous_state)).to eq(true)
    end


    it "can not transition to cooldown" do
      expect( machine.can_transition_to?(:cooldown)).to eq(false)
    end


    context 'when the thermostat allows idle transition' do
      let(:thermostat) { cool_thermostat_class.new }
      it "can transition to idle" do
        expect( machine.can_transition_to?(:idle)).to eq(true)
      end
    end


    context 'when the thermostat does not allow idle transition' do
      let(:thermostat) { hot_thermostat_class.new }
      it "can transition to idle" do
        expect( machine.can_transition_to?(:idle)).to eq(false)
      end
    end
  end


  let(:machine) { described_class.new thermostat}
  let(:thermostat) { nil }

  it 'starts idle' do
    expect( machine.current_state.intern ).to eq :idle
  end


  context 'idling' do

    [ :cooling, :heating ].each do |s|
      it "can transition to #{s}" do
        expect( machine.can_transition_to?(s)).to eq(true)
      end
    end


    it "can not transition to cooldown" do
      expect( machine.can_transition_to?(:cooldown)).to eq(false)
    end

  end


  context 'cooling' do
    before do
      force_state_change(machine, :cooling)
    end

    it_behaves_like 'a running thermostat'

  end


  context 'heating' do
    before do
      force_state_change(machine, :heating)
    end

    it_behaves_like 'a running thermostat'
  end


  context 'cooling_cooldown' do
    let(:previous_state) { :cooling }
    let(:reverse_state) { :heating }
    let(:state) { :cooldown }
    it_behaves_like 'a cooldown thermostat'
  end


  context 'heating_cooldown' do
    let(:previous_state) { :heating }
    let(:reverse_state) { :cooling }
    let(:state) { :cooldown }
    it_behaves_like 'a cooldown thermostat'
  end

end
