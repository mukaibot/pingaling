require 'gateway'
require 'tty-table'
require 'json'

module Actions
  class NotificationChannels
    def get
      gw = Gateway.new
      response = gw.get_notification_channels
      result = JSON.parse(response.body)
      table = TTY::Table.new(headers, parse_results(result))
      puts TTY::Table::Renderer::Basic.new(table, padding: padding).render
    end

    def delete(name)
      gw = Gateway.new
      puts gw.delete_notification_channel(name)
    end

    private

    def headers
      %w(NAME, TYPE, WEBHOOK)
    end

    def parse_results(results)
      to_collection(results.fetch('data', [])).map { |r| r.values_at('name', 'type', 'data') }
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
