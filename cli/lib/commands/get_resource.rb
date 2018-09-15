require 'commands/base'
require 'commands/get/endpoint'
require 'commands/get/incident'
require 'commands/get/notification_channel'

module Commands
  class GetResource < Base
    VALID_RESOURCES = %w(endpoints)

    subcommand ['endpoints'], 'Gets all endpoints', Commands::Get::Endpoint
    subcommand ['endpoint'], 'Gets a specific endpoint', Commands::Get::Endpoint
    subcommand ['incidents'], 'Gets all incidents', Commands::Get::Incident
    subcommand ['notification-channels', 'nc'], 'Gets all notification channels', Commands::Get::NotificationChannel
  end
end
