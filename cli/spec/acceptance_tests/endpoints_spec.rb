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
        expect(output[1]).to start_with "dingbat-poker"
      end
    end
  end

  describe "deleting an endpoint" do
    context "the endpoint doesn't exist" do
      it "returns that the endpoint doesn't exist" do
        Dir.chdir "bin" do
          command            = "./pingaling delete endpoint some-name"
          stderr_out, status = Open3.capture2e(command)
          output             = stderr_out.split("\n")

          aggregate_failures do
            expect(output[0]).to include "does not exist"
          end
        end
      end
    end

    context "the endpoint does exist" do
      it "deletes the endpoint" do
        Dir.chdir "bin" do
          command            = "./pingaling delete endpoint dingbat-poker"
          stderr_out, status = Open3.capture2e(command)
          output             = stderr_out.split("\n")

          aggregate_failures do
            expect(output[0]).to include "Deleted endpoint dingbat-poker"
          end
        end
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
