require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class Incidents
    NO_INCIDENTS = "No incidents!"

    def get
      gw       = Gateway.new
      response = gw.get_incidents
      result   = JSON.parse(response.body)
      data     = parse_results(result)

      if data.any?
        table = TTY::Table.new(headers, data)
        puts TTY::Table::Renderer::Basic.new(table, padding: padding, resize: true).render
      else
        puts NO_INCIDENTS
      end
    end

    private

    def headers
      ['INCIDENT', 'STATUS', 'ENDPOINT', 'URL']
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('id', 'status', 'name', 'url') }
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
