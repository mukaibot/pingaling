require 'spec_helper'
require 'open3'

RSpec.describe "Incidents acceptance test" do
  let(:service) { "dingbat" }

  it "returns the incidents" do
    Dir.chdir "bin" do
      command            = "./pingaling get incidents"
      stderr_out, status = Open3.capture2e(command)
      output             = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to start_with "INCIDENT"
        expect(output[1]).to include service
      end
    end
  end
end
