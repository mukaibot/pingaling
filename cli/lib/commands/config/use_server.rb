require 'commands/base'
require 'actions/servers'

module Commands
  module Config
    class UseServer < Base
      parameter "[NAME]", 'Name of specific server.'
      def execute
        Actions::Servers.new.use(name)
      end
    end
  end
end