module Api::Controllers::Endpoints
  class Show
    include Api::Action
    accept :json
    expose :endpoint

    def call(params)
      @endpoint = EndpointRepository.new.by_name(params[:name]).first
    end
  end
end
