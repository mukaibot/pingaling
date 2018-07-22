module Web::Controllers::Endpoints
  class List
    include Web::Action
    accept :json
    expose :endpoints

    def call(params)
      @endpoints = EndpointRepository.new.all
    end
  end
end
