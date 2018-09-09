require 'yaml'

# read the ~/.pingaling config file
# validate yaml
# return host if not nil
class ClientConfig
  CONFIG_PATH = File.join(File.expand_path('~'), '.pingaling')
  LOCALHOST_SERVER = 'http://localhost:4000/api'
  DEFAULT_URL = ENV.fetch('API_SERVER', LOCALHOST_SERVER)

  attr_accessor :servers, :current_server

  def initialize
    @servers = []
    load_config
  end

  def host
    server = servers.find {|server| server.fetch('name') == current_server}
    server.fetch('server')
  end

  def load_config
    # Load client config file
    if File.exist?(CONFIG_PATH)
      config = YAML.load_file(CONFIG_PATH)
      unless config.nil?
        @servers = config.fetch('servers')
        @current_server = config.fetch('current-server')
        return self
      end
    else
      generate
    end
  end

  def generate
    servers << {
      "server" => DEFAULT_URL,
      "name"   => "localhost",
    }
    @current_server = "localhost"
    write_config
    return self
  end

  def add_server(name)
    puts "server url: [#{DEFAULT_URL}] >"
    server = STDIN.gets.chomp
    server = DEFAULT_URL if server.empty?
    servers << {
                  "server" => server,
                  "name"   => name,
                }
    @current_server = name
    write_config
  end

  def write_config
    File.open(CONFIG_PATH, "w") do |file|
      file.write({
        "servers"        => servers,
        "current-server" => current_server,
      }.to_yaml)
    end
  end
end
