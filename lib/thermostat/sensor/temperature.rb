require 'ruby-units'
class Thermostat::Sensor
  module Temperature

    def temperature
      temperatures.first
    end


    def temperatures
      @temperatures ||= []
    end

  private

    def default_unit
      :tempC
    end


    def temperature=(t)
      if @temperatures.nil?
        @temperatures = [unitify_temp(t)]
      else
        @temperatures[0] = unitify_temp(t)
      end
      temperature
    end


    def temperatures=(array)
      @temperatures = array.map { |t| unitify_temp(t) }
    end


    def unitify_temp(t)
      if t.class == RubyUnits::Unit
        # Can't use #is_a? here becuase RubyUnits::Unit are (confusingly) Numeric
        # https://github.com/olbrich/ruby-units/issues/144
        return t
      elsif t.is_a?(Numeric)
        return Unit.new t, default_unit
      else
        m = "don't know how to handle a #{t.class} temperature"
        if defined? logger
          logger.sensor(:error) { m }
          return nil
        else
          raise m
        end
      end
    end

  end
end
