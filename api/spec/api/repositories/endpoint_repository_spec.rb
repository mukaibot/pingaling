RSpec.describe EndpointRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:name) { 'huboo'}

  before do
    repo.clear
  end

  it 'can fetch an endpoint by name' do
    repo.create(name: name, url: 'jango')

    expect(repo.by_name(name).first.name).to eq(name)
  end
end
