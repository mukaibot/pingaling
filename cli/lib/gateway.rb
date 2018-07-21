require 'net/http'
require 'uri'

class Gateway
  def initialize
    @host = URI.parse('http://localhost:4567/endpoints')
  end

  def get_endpoints
    Net::HTTP.get_response(@host)
  end
end
