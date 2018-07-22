require 'http'

class Gateway
  def initialize
    @host = 'http://localhost:4567'
  end

  def describe_endpoint(name)
    response = HTTP.get(@host + '/describe/endpoints/' + name)
    response.code == 200 ? response : raise(ApiUnavailableError.new(@host))
  end

  def get_endpoint(name)
    response = HTTP.get(@host + '/get/endpoints/' + name)
    response.code == 200 ? response : raise(ApiUnavailableError.new(@host))
  end

  def get_endpoints
    response = HTTP.get(@host + '/get/endpoints')
    response.code == 200 ? response : raise(ApiUnavailableError.new(@host))
  end

  def post_manifest(json)
    HTTP.post(@host + '/manifest', json: json)
  end

  class ApiUnavailableError < StandardError
    def initialize(host)
      super("There was a problem talking to the API at #{host}")
    end
  end
end
