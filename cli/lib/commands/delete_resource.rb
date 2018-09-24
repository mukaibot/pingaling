require 'commands/base'
require 'commands/delete/endpoint'
require 'commands/delete/notification_channel'
require 'commands/delete/notification_policy'

module Commands
  class DeleteResource < Base
    subcommand ['endpoint'], 'Delete the endpoint', Commands::Delete::Endpoint
    subcommand ['notification-channel', 'nc'], 'Delete Notification Channel', Commands::Delete::NotificationChannel
    subcommand ['notification-policy', 'np'], 'Delete Notification Policy', Commands::Delete::NotificationPolicy
  end
end
