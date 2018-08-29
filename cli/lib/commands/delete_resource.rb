require 'commands/base'
require 'commands/delete/endpoint'


module Commands
  class DeleteResource < Base
    subcommand ['endpoint'], 'Delete the endpoint', Commands::Delete::Endpoint

  end
end