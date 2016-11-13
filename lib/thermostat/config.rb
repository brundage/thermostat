class Thermostat
  class Config

    COOLDOWN_SECONDS  = 120
    INITIAL_SET_POINT = 23.9
    MAX_SET_POINT     = 26.7
    MIN_SET_POINT     = 18.3

    def self.default_cooldown_seconds;  COOLDOWN_SECONDS;  end
    def self.default_initial_set_point; INITIAL_SET_POINT; end
    def self.default_max_set_point;     MAX_SET_POINT;     end
    def self.default_min_set_point;     MIN_SET_POINT;     end


    attr_accessor :cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point

    def initialize
      [ :cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point ].each do |m|
        self.send "#{m}=", self.class.send("default_#{m}")
      end
    end

  end
end
