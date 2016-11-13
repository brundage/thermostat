require 'yaml'

class Thermostat
  class ConfigLoader

    class NoConfigError < ArgumentError; end

    def initialize(args)
      @filename      = locate_config_file(args[:filename])
      @stream        = args[:stream]
      @stream_loader = args[:stream_loader] || YAML
    end


    def locate_config_file(key)
       return nil if key == nil
       return key if File.absolute_path(key) == key
       File.expand_path( File.join( config_dir, key ) )
    end


    def read
      raise NoConfigError.new("Please suppply :filename or :stream to ConfigLoader") unless find_stream
      hash = @stream_loader.load_stream(find_stream)[0]
      Config.new hash
    end


  private

    def config_dir
      File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'config' ) )
    end


    def find_stream
      return @stream if @stream
      File.open @filename if @filename
    end

  end
end
