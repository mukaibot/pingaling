require 'database'
require 'repositories/endpoints'
require 'checkers/endpoint'

class Worker
  def initialize(
    endpoint_checker: Checkers::Endpoint.new,
    updater: ResultUpdater.new,
    repository: Repositories::Endpoints.new(Database.instance)
  )
    @endpoint_checker = endpoint_checker
    @updater = updater
    @repo = repository
  end

  def run_checks
    @repo.ready_for_checking.to_a.each do |endpoint|
      result = @endpoint_checker.call(endpoint)
      # @updater.call(id: endpoint.pk, type: :endpoints, check_result: result)
    end
  end
end
