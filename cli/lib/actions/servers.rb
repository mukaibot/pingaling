require 'tty-table'

module Actions

  class Servers
    def current_server
      puts $client_config.current_server
    end

    def get
      table = TTY::Table.new(['SERVER', 'NAME'], rows($client_config.servers))
      puts TTY::Table::Renderer::Basic.new(table, padding: [0, 3, 0, 0]).render
    end

    def rows(results)
      #[['localhost', 'http://localhost:3000'], ['b1', 'b2']]
      results.map {|result| result.map {|k, v| v}}
    end

    def use(name)
      # if given name not exists, no changes
      # if given name exists, change the current_server to it
      if $client_config.servers.find {|server| server.fetch('name') == name}
        $client_config.current_server = name
        $client_config.write_config
      end
      puts "Current server: #{$client_config.current_server}"
    end

    def add(name)
      # abort if name not given
      # do nothing if name already exists
      # otherwise, add server
      abort "Missing name" if name == nil
      unless $client_config.servers.find {|server| server.fetch('name') == name}
        $client_config.add_server(name)
      end
    end
  end

end