require 'ruby-units'
describe Thermostat::HeatIndexCalculator do

  let(:klass) { Class.new do
                  include Thermostat::HeatIndexCalculator
                  attr_accessor :relative_humidity_percent, :temperature
                  def initialize( rh: nil, t: nil)
                    self.relative_humidity_percent = rh
                    self.temperature = t
                  end
                end }
  let(:relative_humidity) { 20 }
  let(:subject) { klass.new rh: relative_humidity, t: temperature }
  let(:temperature) { Unit.new 23, :tempC }
  let(:calculator_scale) { subject.send :heat_index_scale }

  it 'calculates the heat index' do
    expect(subject.heat_index.class).to eq RubyUnits::Unit
  end


  it "calculates the heat index in the class's temperature scale" do
    expect(subject.temperature.units).not_to eq calculator_scale
    expect(subject.heat_index.units).to eq subject.temperature.units
  end

end
