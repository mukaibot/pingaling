module Web
  module Views
    module Endpoints
      class Show
        include Web::View
        layout false

        def render
          _raw JSON.dump(endpoint.to_h)
        end
      end
    end
  end
end
