require 'commands/apply'
require 'commands/get_resource'
require 'commands/config'
require 'commands/delete_resource'

module Commands
  class MainCommand < Base
    subcommand ['apply'], 'Create/update a resource', Commands::Apply
    subcommand ['get'], 'Gets a resource', Commands::GetResource
    subcommand ['config'], 'Modify client config', Commands::ClientConfig
    subcommand ['delete'], 'Delete resources by name', Commands::DeleteResource


    def run(*args)
      super(*args)
    end
  end
end
