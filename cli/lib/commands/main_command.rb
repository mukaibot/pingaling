require 'commands/get_resource'

module Commands
  class MainCommand < Base
    subcommand ['get'], 'Gets a resource', Commands::GetResource

    def run(*args)
      super(*args)
    end
  end
end
