class Thermostat
  module StructInitializer
    # Mixin for initializing a struct from a hash
    # Looks for a #default_blark class method to set the default blark

    def initialize(*args)
      opts = args.last.is_a?(Hash) ? args.pop : Hash.new
      super
      members.each do |k|
        next if self.send(k)
        self.send "#{k}=", (opts[k] || default_value_for(k))
      end
    end

  private

    def default_value_for(key)
      m = "default_#{key}".intern
      self.class.respond_to?(m) ? self.class.send(m) : nil
    end

  end
end
