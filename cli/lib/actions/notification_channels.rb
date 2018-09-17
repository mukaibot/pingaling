require 'gateway'
require 'actions/base'
require 'tty-table'
require 'json'

module Actions
  class NotificationChannels < Base
    def get
      response = gw.get_notification_channels
      result = JSON.parse(response.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    def delete(name)
      puts gw.delete_notification_channel(name)
    end

    private

    def headers
      %w(NAME TYPE WEBHOOK)
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('name', 'type', 'data') }
    end
  end
end
