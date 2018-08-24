require 'commands/base'
require 'actions/servers'

module Commands
  module Config
    class AddServer < Base
      parameter "[NAME]", 'Name of the new server.'
      def execute
        Actions::Servers.new.add(name)
      end
    end
  end
end