require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class Endpoints
    NO_ENDPOINTS = "No endpoints yet".freeze

    def get(name = nil)
      gw       = Gateway.new
      response = name ? gw.get_endpoint(name) : gw.get_health_summary
      result   = JSON.parse(response.body)
      data     = parse_results(result)

      if data.any?
        table = TTY::Table.new(headers, data)
        puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
      else
        puts NO_ENDPOINTS
      end
    end

    def delete(name)
      gw = Gateway.new
      puts gw.delete_endpoint(name)
    end

    private

    def headers
      ['ENDPOINT', 'STATUS', 'URL']
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('name', 'status', 'url') }
    end

    def padding
      [0, 3, 0, 0]
    end

    def to_collection(thing)
      if Hash === thing
        [thing]
      else
        thing
      end
    end
  end
end
