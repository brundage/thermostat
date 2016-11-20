class Thermostat
  class Config < Struct.new(:cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point)

    include StructInitializer

    COOLDOWN_SECONDS  = 120
    INITIAL_SET_POINT = nil
    MAX_SET_POINT     = 26.7
    MIN_SET_POINT     = 18.3

    def self.default_cooldown_seconds;  COOLDOWN_SECONDS;  end
    def self.default_initial_set_point; INITIAL_SET_POINT; end
    def self.default_max_set_point;     MAX_SET_POINT;     end
    def self.default_min_set_point;     MIN_SET_POINT;     end

  end
end
