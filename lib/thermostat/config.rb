class Thermostat
  class Config < Struct.new(:cooldown_seconds, :initial_set_point, :max_set_point, :min_set_point)

    COOLDOWN_SECONDS  = 120
    INITIAL_SET_POINT = 23.9
    MAX_SET_POINT     = 26.7
    MIN_SET_POINT     = 18.3

    def self.default_cooldown_seconds;  COOLDOWN_SECONDS;  end
    def self.default_initial_set_point; INITIAL_SET_POINT; end
    def self.default_max_set_point;     MAX_SET_POINT;     end
    def self.default_min_set_point;     MIN_SET_POINT;     end


    def initialize(*args)
      opts = args.last.is_a?(Hash) ? args.pop : Hash.new
      super
      members.each do |k|
        next if self.send(k)
        self.send "#{k}=", (opts[k] || self.class.send("default_#{k}") )
      end
    end

  end
end
