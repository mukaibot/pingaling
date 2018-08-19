require 'yaml'

# read the ~/.pingaling config file
# validate yaml
# return host if not nil
class ClientConfig

    CONFIG_PATH = File.join(File.expand_path('~'), '.pingaling')

    def host
        # fetch and validate host in config file
        begin
            host = load_config(CONFIG_PATH).fetch('host')
            # validate host start with http
            return host if host.to_s.start_with?('http')
        rescue
            raise(ClientConfigHostNotValid.new(CONFIG_PATH))
        end
    end

    def load_config(path)
        # Load client config file
        if File.exist?(path)
            begin
                config = YAML.load_file(path)
                return config unless config.nil?
            rescue
                raise(ArgumentError, "'#{path}' is not a valid file")
            end
        else
            raise(ClientConfigNotFound.new(path))
        end
        raise(ArgumentError, "'#{path}' is not a valid file")
    end

    class ClientConfigNotFound < StandardError
        def initialize(path)
            super("#{path} not found")
        end
    end

    class ClientConfigHostNotValid < StandardError
        def initialize(path)
            super("Failed to fetch host from #{path}")
        end
    end

end