require 'spec_helper'
require 'open3'

RSpec.describe "Endpoints acceptance test" do
  it "returns the endpoints" do
    Dir.chdir "bin" do
      command            = "./pingaling get endpoints"
      stderr_out, status = Open3.capture2e(command)
      output             = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to start_with "ENDPOINT"
        expect(output[1]).to start_with "dingbat"
      end
    end
  end
end
