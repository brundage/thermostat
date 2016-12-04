class Thermostat
  class Zone

    include Logger

    attr_reader :config, :fan, :name, :sensors, :set_point, :thermostat

    def initialize(**args)
      init_args(args).each_pair do |name,component|
        raise ArgumentError.new("Zone must be initialized with a #{name}") if component.nil?
      end
      self.config         = args[:config] || thermostat.default_config
      self.fan            = args[:fan]
      self.name           = args[:name]
      self.sensors        = args[:sensors]
      self.thermostat     = args[:thermostat]
      self.set_point      = args[:set_point]
      logger.debug "zone #{self.name} initialized"
    end


    def max_set_point; config.max_set_point; end

    def min_set_point; config.min_set_point; end


    def set_point=(s)
      unless s.nil?
        raise InvalidSetpoint, "Set point (#{s}) should be a Unit or nil" unless s.is_a?(Numeric)
        if s < min_set_point || s > max_set_point
          raise InvalidSetpoint, "Set point (#{s}) should be between #{min_set_point} and #{max_set_point}"
        end
      end
      @set_point = s
    end

  private

    attr_writer :config, :fan, :name, :sensors, :thermostat

    def init_args(**args)
      required_init_args.map { |a| [a, args[a] ] }.to_h
    end


    def required_init_args
      [ :fan, :name, :sensors, :thermostat ]
    end

  end
end
