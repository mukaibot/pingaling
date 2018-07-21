require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class Endpoints
    def get
      gw = Gateway.new
      result = JSON.parse(gw.get_endpoints.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    private

    def headers
      ['ENDPOINT', 'STATUS', 'PATH']
    end

    def parse_results(results)
      results.map { |r| r.values_at('name', 'status', 'path') }
    end

    def padding
      [0, 3, 0, 0]
    end
  end
end
