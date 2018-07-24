require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class Endpoints
    def get(name = nil)
      gw = Gateway.new

      response = name ? gw.get_endpoint(name) : gw.get_endpoints
      result = JSON.parse(response.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    private

    def headers
      ['ENDPOINT', 'STATUS', 'PATH']
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
