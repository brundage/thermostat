class Thermostat
  class Sensor

    autoload :RelativeHumidity, File.join('thermostat', 'sensor', 'relative_humidity')
    autoload :Temperature, File.join('thermostat', 'sensor', 'temperature')

    def initialize(data_source:)
      @data_source = data_source
    end

  private

    attr_reader :data_source

  end
end
