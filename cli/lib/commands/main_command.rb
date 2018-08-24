require 'commands/apply'
require 'commands/get_resource'
require 'commands/config'

module Commands
  class MainCommand < Base
    subcommand ['apply'], 'Create/update a resource', Commands::Apply
    subcommand ['get'], 'Gets a resource', Commands::GetResource
    subcommand ['config'], 'Modify client config', Commands::ClientConfig


    def run(*args)
      super(*args)
    end
  end
end
