require 'commands/base'
require 'commands/config/current_server'
require 'commands/config/get_servers'
require 'commands/config/use_server'

module Commands
  class ClientConfig < Base
    subcommand ['current-server'], 'Gets the current server', Commands::Config::CurrentServer
    subcommand ['get-servers'], 'Gets all servers', Commands::Config::GetServers
    subcommand ['use-server'], 'Use a specific server', Commands::Config::UseServer
  end
end