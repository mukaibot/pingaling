module Api::Controllers::Endpoints
  class List
    include Api::Action
    accept :json
    expose :endpoints

    def call(params)
      @endpoints = EndpointRepository.new.all
    end
  end
end
