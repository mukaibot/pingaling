require 'spec_helper'
require 'open3'

RSpec.describe 'Notification policies acceptance test' do
  it 'returns the notification policies' do
    Dir.chdir 'bin' do
      command     = './pingaling get np'
      stderr_out, = Open3.capture2e(command)
      output      = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to start_with 'NAME'
        expect(output[1]).to include 'alert-bar'
      end
    end
  end

  it 'returns the deleted message' do
    Dir.chdir 'bin' do
      command     = './pingaling delete np alert-bar'
      stderr_out, = Open3.capture2e(command)
      output      = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to include 'Deleted notification policy alert-bar'
      end
    end
  end
end
