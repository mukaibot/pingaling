require 'worker'

RSpec.describe Worker do
  let(:checker) { double(Checkers::Endpoint) }
  let(:updater) { double(ResultUpdater) }

  before do
    allow(checker).to receive(:call)
    allow(updater).to receive(:call)
  end

  it 'checks the endpoint' do
    worker = Worker.new(endpoint_checker: checker, updater: updater, repository: repository)
    worker.run_checks

    expect(endpoint.throbble).to eq("bah")
    expect(endpoint).to eq repository.ready_for_checking.to_a.first

    # expect(checker).to have_received(:call).with(endpoint)
  end

  def xtest_it_updates
    checker = Minitest::Mock.new
    updater = Minitest::Mock.new
    updater.expect(:call, nil)

    worker = Worker.new(endpoint_checker: checker, updater: updater)
    worker.run_checks

    updater.verify
  end

  private

  def repository
    Repositories::Endpoints.new(Database.instance)
    # Endpoint.new(Database.instance)
  end

  def endpoint
    repository.ready_for_checking.to_a.first
  end
end
