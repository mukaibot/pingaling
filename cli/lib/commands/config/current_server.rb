require 'commands/base'
require 'actions/servers'

module Commands
  module Config
    class CurrentServer < Base
      def execute
        Actions::Servers.new.current_server
      end
    end
  end
end