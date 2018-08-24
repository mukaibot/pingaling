require 'tty-table'

module Actions

  class Servers
    def current_server
      puts $client_config.current_server
    end

    def get
      puts $client_config.servers
      # TODO: Print out a pretty table
    end

    def use(name)
      # if given name not exists, no changes
      # if given name exists, change the current_server to it
      
      for server in $client_config.servers
        if server['name'] == name
          $client_config.current_server = name
          $client_config.write_config
        end
      end
      puts "Current server: #{$client_config.current_server}"
    end

    def add(name)
      if name == nil
        puts "Missing name"
        return nil
      end
      server_exist = false
      for server in $client_config.servers
        if server['name'] == name
          puts "Server name '#{name}' already exists"
          server_exist = true
        end 
      end
      $client_config.add_server(name) unless server_exist
    end
  end

end