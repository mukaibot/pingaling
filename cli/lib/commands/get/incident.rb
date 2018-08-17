require 'commands/base'
require 'actions/incidents'

module Commands
  module Get
    class Incident < Base
      def execute
        Actions::Incidents.new.get
      end
    end
  end
end
