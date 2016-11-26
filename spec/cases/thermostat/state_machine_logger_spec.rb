require 'statesman'
describe Thermostat::StateMachineLogger do

  let(:klass) { Class.new do
                  include Statesman::Machine
                  extend Thermostat::StateMachineLogger
                  state :first, initial: true
                  state :second
                  transition from: :first, to: :second
                end }
  let(:logger) { double :logger, debug: nil }
  let(:object) { double :object, logger: logger }
  let(:subject) { klass.new object }

  before do
    subject.transition_to :second
  end

  it 'logs transitions' do
    expect( object.logger ).to have_received(:debug).twice
  end

end
