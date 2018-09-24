require 'commands/base'
require 'actions/notification_policies'

module Commands
  module Get
    class NotificationPolicy < Base
      def execute
        Actions::NotificationPolicies.new.get
      end
    end
  end
end
