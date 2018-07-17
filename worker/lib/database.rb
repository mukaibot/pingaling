require "rom"
require "rom-sql"
require "relations/endpoints"

class Database
  class << self
    def instance
      configuration = ROM::Configuration.new(:sql, "postgres://#{ENV.fetch('DB_HOST')}/#{ENV.fetch('DB_NAME')}")
      load_path = File.expand_path(__dir__)
      configuration.register_relation(Relations::Endpoints)
      container = ROM.container(configuration)
      container
    end
  end
end
