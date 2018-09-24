require 'gateway'
require 'actions/base'
require 'tty-table'
require 'json'

module Actions
  class NotificationPolicies < Base
    def get
      response = gw.get_notification_policies
      result = JSON.parse(response.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    def delete(name)
      puts gw.delete_notification_policy(name)
    end

    private

    def headers
      %w(NAME TYPE ENDPOINT CHANNEL)
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('name', 'type', 'endpoint', 'channel') }
    end
  end
end
