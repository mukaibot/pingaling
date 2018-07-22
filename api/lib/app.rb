require 'sinatra'
require 'json'
require_relative './endpoint'

get '/version' do
  '1.0.0'
end

get '/endpoints' do
  ep = []
  5.times do
    ep << Endpoint.random
  end

  ep.to_json
end

post '/manifest' do
  'Ok!'
end
