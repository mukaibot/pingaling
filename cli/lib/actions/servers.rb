require 'tty-table'

module Actions
  class Servers
    def current_server
      puts config.current_server
    end

    def config
      @config ||= ClientConfig.new
    end

    def get
      table = TTY::Table.new(['SERVER', 'NAME'], rows(config.servers))
      puts TTY::Table::Renderer::Basic.new(table, padding: [0, 3, 0, 0]).render
    end

    def rows(results)
      results.map {|result| result.map {|k, v| v}}
    end

    def use(name)
      # if given name not exists, no changes
      # if given name exists, change the current_server to it
      if config.servers.find {|server| server.fetch('name') == name}
        config.current_server = name
        config.write_config
      end
      puts "Current server: #{config.current_server}"
    end

    def add(name)
      # abort if name not given
      # do nothing if name already exists
      # otherwise, add server
      abort "Missing name" if name == nil
      unless config.servers.find {|server| server.fetch('name') == name}
        config.add_server(name)
      end
    end
  end
end
