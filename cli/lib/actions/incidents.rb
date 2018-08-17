require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class Incidents
    def get
      gw = Gateway.new

      response = gw.get_incidents
      result = JSON.parse(response.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    private

    def headers
      ['INCIDENT', 'STATUS', 'ENDPOINT', 'UPDATED', 'URL']
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('id', 'status', 'name', 'updated_at', 'url') }
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
