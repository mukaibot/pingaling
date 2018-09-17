# frozen_string_literal: true

require 'factory'
require 'actions/base'
require 'tty-table'
require 'json'

module Actions
  class Endpoints < Base
    NO_ENDPOINTS = 'No endpoints yet'

    def get(name = nil)
      response = name ? gw.get_endpoint(name) : gw.get_health_summary
      result   = JSON.parse(response.body)
      data     = parse_results(result)

      if data.any?
        table = TTY::Table.new(headers, data)
        outputter.write TTY::Table::Renderer::Basic.new(table, padding: padding).render
      else
        outputter.write NO_ENDPOINTS
      end
    end

    def delete(name)
      outputter.write gw.delete_endpoint(name)
    end

    private

    def headers
      %w[ENDPOINT STATUS URL].freeze
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('name', 'status', 'url') }
    end
  end
end
