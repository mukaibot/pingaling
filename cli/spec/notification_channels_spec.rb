require 'spec_helper'
require 'open3'

RSpec.describe 'Notification channels acceptance test' do
  it 'returns the notification channels' do
    Dir.chdir 'bin' do
      command       = './pingaling get nc'
      stderr_out, _ = Open3.capture2e(command)
      output        = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to start_with 'NAME'
        expect(output[1]).to include 'slack'
      end
    end
  end

  it 'returns the deleted message' do
    Dir.chdir 'bin' do
      command       = './pingaling delete nc slacktastic'
      stderr_out, _ = Open3.capture2e(command)
      output        = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to include 'Deleted notification channel slacktastic'
      end
    end
  end
end
