require 'commands/base'
require 'actions/endpoints'

module Commands
  module Delete
    class Endpoint < Base
      parameter "NAME", 'Name of specific endpoint.'

      def execute
        Actions::Endpoints.new.delete(name)
      end
    end
  end
end
