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
      
      # server_exist = false
      # for server in $client_config.servers
      #   if server['name'] == name
      #     server_exist = true
      #   end 
      # end
      unless $client_config.servers.find {|server| server.fetch('name') == name}
        $client_config.add_server(name)
      end
    end
  end

end