require 'commands/base'
require 'commands/delete/endpoint'
require 'commands/delete/notification_channel'

module Commands
  class DeleteResource < Base
    subcommand ['endpoint'], 'Delete the endpoint', Commands::Delete::Endpoint
    subcommand ['notification-channels', 'nc'], 'Gets all notification channels', Commands::Delete::NotificationChannel
  end
end