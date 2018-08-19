require 'yaml'

class ClientConfig
    # read the ~/.pingaling config file
    # validate yaml
    # return host if not nil

    def initialize
        @path = config_path
    end

    def host
        # fetch and validate host in config file
        begin
            host = load_config(@path).fetch('host')
            # validate host not nil, and start with http
            return host if host.to_s.start_with?('http')
            raise(ClientConfigHostNotValid.new(@path))
        rescue
            raise(ArgumentError, "Failed to fetch host from #{@path}")
        end
    end

    def config_path
        # Describe the home path to config file
        File.join(File.expand_path('~'), '.pingaling')
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
            super("Host not valid in #{path}")
        end
    end

end