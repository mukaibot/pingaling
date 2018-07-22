require 'sinatra'
require 'json'
require_relative './endpoint'

VALID_RESOURCES = %w(endpoint)

get '/version' do
  '1.0.0'
end

get '/get/endpoints/:name' do
  Endpoint.random(params[:name]).to_json
end

get '/get/endpoints' do
  ep = []
  5.times do
    ep << Endpoint.random
  end

  ep.to_json
end

get '/describe/:resource/:name' do
  resource_type = params[:resource]
  resource_name = params[:name]

  if VALID_RESOURCES.include?(resource_type)
    describe_resource(resource_name)
  else
    [400, "Invalid resource type. Valid resources are: #{VALID_RESOURCES.join(', ')}"]
  end
end

post '/manifest' do
  'Ok!'
end

private

def describe_resource(name)
  Endpoint.random(name).to_json
end
