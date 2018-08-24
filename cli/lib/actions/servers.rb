require 'tty-table'

module Actions

  class Servers
    def current_server
      puts CLIENT_CONFIG.current_server
    end

    def get
      puts CLIENT_CONFIG.servers
    end
    
    def use(name)
      # if given name not exists, no changes
      # if given name exists, change the current_server to it
      
      for server in CLIENT_CONFIG.servers
        if server['name'] == name
          CLIENT_CONFIG.current_server = name
          CLIENT_CONFIG.write_config
        end
      end
      puts "Current server: #{CLIENT_CONFIG.current_server}"
    end

  end

end