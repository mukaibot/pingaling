require 'http'
require 'client_config'

class Gateway
  def initialize
    @config = ClientConfig.new
    @host   = @config.host
  end

  def describe_endpoint(name)
    handle_response HTTP.get(@host + '/endpoints/describe/' + name)
  end

  def get_endpoint(name)
    handle_response HTTP.get(@host + '/endpoints/' + name)
  end

  def delete_endpoint(name)
    handle_response HTTP.delete(@host + '/endpoints/' + name)
  end

  def get_notification_channels
    handle_response HTTP.get(@host + '/notification_channels/')
  end

  def delete_notification_channel(name)
    handle_response HTTP.delete(@host + '/notification_channels/' + name)
  end

  def get_notification_policies()
    handle_response HTTP.get(@host + '/notification_policies/')
  end

  def delete_notification_policy(name)
    handle_response HTTP.delete(@host + '/notification_policies/' + name)
  end

  def get_health_summary
    handle_response HTTP.get(@host + '/health/summary')
  end

  def get_incidents
    handle_response HTTP.get(@host + '/incidents')
  end

  def post_manifest(json)
    handle_response HTTP.post(@host + '/manifest', json: { manifest: json })
  end

  class ApiUnavailableError < StandardError
    def initialize(host)
      super("There was a problem talking to the API at #{host}")
    end
  end

  private

  def handle_response(response)
    case response.code
    when 200
      response
    when 404
      response
    else
      raise(ApiUnavailableError.new(@host))
    end
  end
end
