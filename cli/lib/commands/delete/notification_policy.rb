require 'commands/base'
require 'actions/notification_policies'

module Commands
  module Delete
    class NotificationPolicy < Base
      parameter "NAME", 'Name of specific notification policy.'

      def execute
        Actions::NotificationPolicies.new.delete(name)
      end
    end
  end
end
