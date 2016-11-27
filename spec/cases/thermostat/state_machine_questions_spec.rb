describe Thermostat::StateMachineQuestions do

  let(:klass) { Class.new do  # Order is important here
                  def self.states; [:blark]; end
                  include Thermostat::StateMachineQuestions
                end }
  let(:subject) { klass.new }


  it 'defines a :blark? method' do
    expect(subject).to respond_to :blark?
  end

end
