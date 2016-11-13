require 'helpers/state_machine'

class CoolThermostat
  def cooling_cooldown_passed?; true; end
  def heating_cooldown_passed?; true; end
end


class HotThermostat
  def cooling_cooldown_passed?; false; end
  def heating_cooldown_passed?; false; end
end


describe Thermostat::HeatPump::StateMachine do

  shared_examples_for 'a running thermostat' do
    [ :idle, :cooling, :heating ].each do |s|
      it "can not transition to #{s}" do
        expect( machine.can_transition_to?(s)).to eq(false)
      end
    end
  end


  shared_examples_for 'a cooldown thermostat' do
    before do
      force_state_change(machine, state)
    end

    it 'can go back' do
      expect( machine.can_transition_to?(previous_state)).to eq(true)
    end


    it 'can not reverse' do
      expect( machine.can_transition_to?(reverse_state)).to eq(false)
    end


    [ :cooling_cooldown, :heating_cooldown ].each do |s|
      it "can not transition to #{s}" do
        expect( machine.can_transition_to?(s)).to eq(false)
      end
    end


    context 'when the thermostat allows idle transition' do
      let(:thermostat) { CoolThermostat.new }
      it "can transition to idle" do
        expect( machine.can_transition_to?(:idle)).to eq(true)
      end
    end


    context 'when the thermostat does not allow idle transition' do
      let(:thermostat) { HotThermostat.new }
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


    [ :cooling_cooldown, :heating_cooldown, :idle ].each do |s|
      it "can not transition to #{s}" do
        expect( machine.can_transition_to?(s)).to eq(false)
      end
    end

  end


  context 'cooling' do
    before do
      force_state_change(machine, :cooling)
    end

    it_behaves_like 'a running thermostat'


    it "can transition to cooling_cooldown" do
      expect( machine.can_transition_to?(:cooling_cooldown)).to eq(true)
    end


    it "can not transition to heating_cooldown" do
      expect( machine.can_transition_to?(:heating_cooldown)).to eq(false)
    end

  end


  context 'heating' do
    before do
      force_state_change(machine, :heating)
    end

    it_behaves_like 'a running thermostat'


    it "can transition to heating_cooldown" do
      expect( machine.can_transition_to?(:heating_cooldown)).to eq(true)
    end


    it "can not transition to cooling_cooldown" do
      expect( machine.can_transition_to?(:cooling_cooldown)).to eq(false)
    end

  end


  context 'cooling_cooldown' do
    let(:previous_state) { :cooling }
    let(:reverse_state) { :heating }
    let(:state) { :cooling_cooldown }
    it_behaves_like 'a cooldown thermostat'
  end


  context 'heating_cooldown' do
    let(:previous_state) { :heating }
    let(:reverse_state) { :cooling }
    let(:state) { :heating_cooldown }
    it_behaves_like 'a cooldown thermostat'
  end

end
