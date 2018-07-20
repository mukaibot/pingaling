require 'check_result'

module Checkers
  class Endpoint
    def call(endpoint)
      # todo - use an actual HTTP client
      CheckResult.new(success: true)
    end
  end
end
