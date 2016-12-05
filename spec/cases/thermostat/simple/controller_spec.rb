describe Thermostat::Simple::Controller do

  let(:cool_relay) { nil }
  let(:cooldown_seconds) { nil }
  let(:cooldown_state) { 'cooldown'.freeze }
  let(:fan_relay) { nil }
  let(:heat_relay) { double :heat_relay }
  let(:subject) { described_class.new cool_relay: cool_relay, fan_relay: fan_relay, heat_relay: heat_relay, cooldown_seconds: cooldown_seconds, state_machine: state_machine }
  let(:state_machine) { double :state_machine }


  shared_examples_for 'a cool controller' do
    it 'passes cooldown_passed?' do
      expect(subject.cooldown_passed?).to be_truthy
    end
  end


  shared_examples_for 'a hot controller' do
    it 'fails cooldown_passed?' do
      expect(subject.cooldown_passed?).to be_falsey
    end
  end


  describe 'cooldown' do
    let(:transition_class) { Struct.new(:created_at, :to_state) }
    let(:cooldown_seconds) { 120 }
    let(:transition) { transition_class.new(time, cooldown_state) }

    context 'with no cooldowns' do
      let(:state_machine) { double :state_machine, history: [] }
      it_behaves_like 'a cool controller'
    end


    context 'inside the cooldown period' do
      let(:state_machine) { double :state_machine, history: [transition] }
      let(:time) { Time.now }
      it_behaves_like 'a hot controller'
    end


    context 'outside the cooldown period' do
      let(:state_machine) { double :state_machine, history: [transition] }
      let(:time) { Time.now-cooldown_seconds-50 }
      it_behaves_like 'a cool controller'
    end


    context 'with multiple cooldown transitions' do
      let(:state_machine) { double :state_machine, history: transitions }
      let(:transitions) { [ transition1, transition2, transition3 ] }
      let(:transition1) { transition_class.new time1, cooldown_state }
      let(:transition2) { transition_class.new time2, cooldown_state }
      let(:transition3) { transition_class.new time3, cooldown_state }
      let(:time1) { Time.now - 2* cooldown_seconds }
      let(:time2) { Time.now - cooldown_seconds }

      describe 'inside the cooldown period' do
        let(:time3) { Time.now }
        it_behaves_like 'a hot controller'
      end


      describe 'outside the cooldown period' do
        let(:time3) { Time.now - cooldown_seconds }
        it_behaves_like 'a cool controller'
      end

    end

  end

end
