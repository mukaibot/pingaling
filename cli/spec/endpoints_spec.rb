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

  it "delete the endpoint" do
    Dir.chdir "bin" do
      command            = "./pingaling delete endpoint widget-aligner"
      stderr_out, status = Open3.capture2e(command)
      output             = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to include "Deleted endpoint widget-aligner"
      end
    end
  end

  it "return error on no NAME to delete" do
    Dir.chdir "bin" do
      command            = "./pingaling delete endpoint"
      stderr_out, status = Open3.capture2e(command)
      output             = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to include "no value provided"
      end
    end
  end
end
