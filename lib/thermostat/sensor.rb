class Thermostat
  class Sensor

    autoload :RelativeHumidity, File.join('thermostat', 'sensor', 'relative_humidity')
    autoload :Temperature, File.join('thermostat', 'sensor', 'temperature')

  end
end
