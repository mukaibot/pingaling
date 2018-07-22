module Api
  module Views
    module Endpoints
      class Show
        include Api::View
        layout false

        def render
          _raw JSON.dump(endpoint.to_h)
        end
      end
    end
  end
end
