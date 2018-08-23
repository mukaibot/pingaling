require 'yaml'

# read the ~/.pingaling config file
# validate yaml
# return host if not nil
class ClientConfig

    CONFIG_PATH = File.join(File.expand_path('~'), '.pingaling')

    attr_accessor :apiVersion, :servers, :current_server

    def initialize
        load_config
    end

    def load_config
        # Load client config file
        if File.exist?(CONFIG_PATH)
            config = YAML.load_file(CONFIG_PATH)
            unless config.nil?
                @apiVersion = config.fetch('apiVersion')
                @servers = config.fetch('servers')
                @current_server = config.fetch('current-server')
                return self
            end

        else
            raise(ClientConfigNotFound.new)
        end
    end

    class ClientConfigNotFound < StandardError
        def initialize
            super("#{CONFIG_PATH} not found")
        end
    end

end