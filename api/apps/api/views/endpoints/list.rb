module Api
  module Views
    module Endpoints
      class List
        include Api::View
        layout false

        def render
          _raw JSON.dump(endpoints.map { |ep| ep.to_h })
        end
      end
    end
  end
end
