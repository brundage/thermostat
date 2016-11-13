class Thermostat
  module Configurable

    def configure(&block)
      @config ||= Config.new
      yield @config if block_given?
      @config
    end


    def config; @config || configure; end

  end
end
