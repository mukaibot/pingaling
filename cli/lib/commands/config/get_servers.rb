require 'commands/base'
require 'actions/servers'

module Commands
  module Config
    class GetServers < Base
      def execute
        Actions::Servers.new.get
      end
    end
  end
end