require 'commands/base'
require 'commands/get/endpoint'
require 'actions/endpoints'

module Commands
  class GetResource < Base
    VALID_RESOURCES = %w(endpoints)

    subcommand ['endpoint'], 'Gets one or more endpoints', Commands::Get::Endpoint
  end
end
