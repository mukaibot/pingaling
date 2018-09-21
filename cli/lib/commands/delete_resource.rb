require 'commands/base'
require 'commands/delete/endpoint'
require 'commands/delete/notification_channel'

module Commands
  class DeleteResource < Base
    subcommand ['endpoint'], 'Delete the endpoint', Commands::Delete::Endpoint
    subcommand ['notification-channel', 'nc'], 'Delete Notification Channel', Commands::Delete::NotificationChannel
  end
end
