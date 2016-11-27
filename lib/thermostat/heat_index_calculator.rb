require 'ruby-units'
class Thermostat
  module HeatIndexCalculator

    # https://en.wikipedia.org/wiki/Heat_index#Formula
    def heat_index
      t = temperature.convert_to(heat_index_scale).scalar
      r = relative_humidity_percent
      hi = hi_c1 + hi_c2*t + hi_c3*r + hi_c4*t*r + hi_c5*t**2 + hi_c6*r**2 + hi_c7*r*t**2 + hi_c8*t*r**2 + hi_c9*(t*r)**2
      return Unit.new(hi, heat_index_scale).convert_to(temperature)
    end

  private

    def heat_index_scale
      'tempF'
    end


    def hi_c1; -42.379;               end
    def hi_c2;   2.04901523;          end
    def hi_c3;  10.14333127;          end
    def hi_c4;  -0.22475541;          end
    def hi_c5;  -6.83783 * 10 ** -3;  end
    def hi_c6;  -5.481717 * 10 ** -2; end
    def hi_c7;   1.22874 * 10 ** -3;  end
    def hi_c8;   8.5282 * 10 ** -4;   end
    def hi_c9;  -1.99 * 10 ** -6;     end

  end
end
