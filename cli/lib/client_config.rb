require 'yaml'

class ClientConfig
    # read the ~/.pingaling config file
    # validate yaml
    # return host if not nil

    def initialize
        @path = config_path
    end

    def host
        load_config(@path)['host']
    end
 
    def fetch_host(config)
        begin
            host = config.fetch('host') 
            return host unless host.nil?
            raise(ClientConfigHostNotFound.new(@path))
        rescue
            raise(ArgumentError, "#{config} is not valid")
        end
    end

    def config_path
        File.join(File.expand_path('~'), '.pingaling')
    end

    def load_config(path)
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

    class ClientConfigHostNotFound < StandardError
        def initialize(path)
            super("Host not found in #{path}")
        end
    end

end