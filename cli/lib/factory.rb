require 'gateway'
require 'stdout_outputter'
require_relative '../spec/fake_gateway'
require_relative '../spec/../spec/fake_outputter'

class Factory
  class << self
    def gateway
      if ENV['GATEWAY_MODE'] == 'fake'
        FakeGateway.new
      else
        Gateway.new
      end
    end

    def outputter
      if ENV['GATEWAY_MODE'] == 'fake'
        FakeOutputter.new
      else
        StdoutOutputter.new
      end
    end
  end
end
