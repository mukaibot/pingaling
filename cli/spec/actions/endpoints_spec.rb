require 'spec_helper'
require 'actions/endpoints'

RSpec.describe Actions::Endpoints do
  subject { described_class.new }

  let(:expected) { "my-service28    pending    http://foobar.com.au/diagnostic   " }

  it 'returns all endpoints' do
    subject.get

    first_message = subject.outputter.messages.first.split("\n")

    expect(first_message).to include(expected)
  end
end
