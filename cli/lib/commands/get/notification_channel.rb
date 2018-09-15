require 'commands/base'
require 'actions/notification_channels'

module Commands
  module Get
    class NotificationChannel < Base
      def execute
        Actions::NotificationChannels.new.get
      end
    end
  end
end
