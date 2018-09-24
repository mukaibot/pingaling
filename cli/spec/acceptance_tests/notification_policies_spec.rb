require 'spec_helper'
require 'open3'

RSpec.describe 'Notification policies acceptance test' do
  let(:notification_policy1) { 'alert-bar' }
  let(:notification_policy2) { 'alert-widget' }

  it 'returns the notification policies' do
    Dir.chdir 'bin' do
      command     = './pingaling get np'
      stderr_out, = Open3.capture2e(command)
      output      = stderr_out.split("\n")

      aggregate_failures do
        expect(output[0]).to start_with 'NAME'
        expect(output.join).to include notification_policy1
      end
    end
  end

  it 'returns the deleted message' do
    Dir.chdir 'bin' do
      command     = "./pingaling delete np #{notification_policy2}"
      stderr_out, = Open3.capture2e(command)

      aggregate_failures do
        expect(stderr_out).to include "Deleted notification policy #{notification_policy2}"
      end
    end
  end
end
