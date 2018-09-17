# frozen_string_literal: true

require 'actions/base'
require 'factory'
require 'tty-table'
require 'json'

module Actions
  class Incidents < Base
    NO_INCIDENTS = 'No incidents!'

    def get
      response = gw.get_incidents
      result   = JSON.parse(response.body)
      data     = parse_results(result)

      if data.any?
        table = TTY::Table.new(headers, data)
        outputter.write TTY::Table::Renderer::Basic.new(table, padding: padding, resize: true).render
      else
        outputter.write NO_INCIDENTS
      end
    end

    private

    def headers
      %w[INCIDENT STATUS ENDPOINT URL].freeze
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('id', 'status', 'name', 'url') }
    end
  end
end
