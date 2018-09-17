require 'spec_helper'
require 'json'
require 'fake_gateway'

RSpec.describe FakeGateway do
  subject { described_class.new }

  let(:health_summary) do
    {
      "data" => [
        {
          "url"     => "http://foobar.com.au/diagnostic",
          "updated" => nil,
          "type"    => "endpoint",
          "status"  => "pending",
          "name"    => "my-service28"
        },
        {
          "url"     => "https://dingbats.svc.local/boop",
          "updated" => nil,
          "type"    => "endpoint",
          "status"  => "pending",
          "name"    => "my-service29"
        }
      ]
    }
  end

  it 'returns the doc value for getting health summaries' do
    expect(JSON.parse(subject.get_health_summary.body)).to eq health_summary
  end
end
