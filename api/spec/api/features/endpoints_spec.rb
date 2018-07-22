require 'features_helper'

describe 'Getting endpoints' do
  let(:name) { 'foobar' }
  let(:other_endpoint) { 'huboo' }
  let(:repo) { EndpointRepository.new }

  before do
    repo.clear
    repo.create(name: name)
    repo.create(name: other_endpoint)
  end

  it 'can get all endpoints' do
    visit '/endpoints'

    expect(body).to include(name)
    expect(body).to include(other_endpoint)
  end

  it 'can get a specific endpoint' do
    visit "/endpoints/#{name}"

    result = JSON.parse(body)

    expect(result.fetch('name')).to eq(name)
  end
end
