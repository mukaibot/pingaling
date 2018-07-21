require 'commands/base'
require 'actions/endpoints'

module Commands
  class GetResource < Base
    VALID_RESOURCES = %w(endpoints)

    parameter "RESOURCE", "One of: #{VALID_RESOURCES.join(", ")}" do |input|
      VALID_RESOURCES.include?(input.downcase) ? input.downcase : raise(ArgumentError, "Unknown resource. Valid types are #{VALID_RESOURCES.join(",")}")
    end

    def execute
      case resource
      when "endpoints"
        Actions::Endpoints.new.get
      end
    end
  end
end
