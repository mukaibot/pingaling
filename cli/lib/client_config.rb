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
      generate
    end
end

  def generate
    # generate the config from user input
    puts "apiVersion: [v1] >"
    @apiVersion = gets.chomp
    @apiVersion = 'v1' if @apiVersion.empty?

    puts "server name: [localhost] >"
    name = gets.chomp
    name = 'localhost' if name.empty?

    puts "server url: [http://localhost:4000] >"
    server = gets.chomp
    server = 'http://localhost:4000' if server.empty?

    @servers = [
      {
        "name"   => name,
        "server" => server
      }
    ]
    @current_server = server
    return self
    # TODO: write the config to .pingaling
  end

  class ClientConfigNotFound < StandardError
    def initialize
      super("#{CONFIG_PATH} not found")
    end
  end

end