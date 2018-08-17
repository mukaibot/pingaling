require 'commands/base'
require 'actions/endpoints'

module Commands
  module Get
    class Endpoint < Base
      parameter "[NAME]", 'Name of specific endpoint. Not specifying a name will return all endpoints'

      def execute
        Actions::Endpoints.new.get(name)
      end
    end
  end
end
