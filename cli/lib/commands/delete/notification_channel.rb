require 'commands/base'
require 'actions/notification_channels'

module Commands
  module Delete
    class NotificationChannel < Base
      parameter "NAME", 'Name of specific notification channel.'

      def execute
        Actions::NotificationChannels.new.delete(name)
      end
    end
  end
end
