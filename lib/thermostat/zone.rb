class Thermostat
  class Zone

    attr_reader :config, :fan, :heat_pump, :outside_sensor, :sensors, :set_point, :thermostat

    def initialize(config: nil, fan: Fan.new, heat_pump: HeatPump.new, outside_sensor: Sensor.new, sensors: [], set_point: nil, thermostat: nil)
      raise ArgumentError.new("Need a thermostat") if thermostat.nil?
      @config         = config || thermostat.default_config
      @fan            = fan
      @heat_pump      = heat_pump
      @outside_sensor = outside_sensor
      @sensors        = sensors
      @thermostat     = thermostat
      self.set_point  = set_point
    end


    def max_set_point; config.max_set_point; end
    def min_set_point; config.min_set_point; end


    def set_point=(s)
      unless s.nil?
        raise InvalidSetpoint, "Set point (#{s}) should be a numeric or nil" unless s.is_a?(Numeric)
        if s < min_set_point || s > max_set_point
          raise InvalidSetpoint, "Set point (#{s}) should be between #{min_set_point} and #{max_set_point}"
        end
      end
      @set_point = s
    end

  end
end
