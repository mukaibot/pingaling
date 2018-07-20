require "rom-sql"
require "entities/endpoint"
require "relations/endpoints"

class Database
  class << self
    def instance
      configuration = ROM::Configuration.new(:sql, "postgres://#{ENV.fetch('DB_HOST')}/#{ENV.fetch('DB_NAME')}")
      # configuration.relation(:endpoints) do
      #   schema(infer: true)
      #   # struct_namespace Entities
      #   auto_struct true
    # end
      configuration.register_relation(Relations::Endpoints)
    #   configuration.auto_registration('.')
      container = ROM.container(configuration)
      container
    end

    def ddl_instance
      configuration = ROM::Configuration.new(:sql, "postgres://#{ENV.fetch('DB_HOST')}/#{ENV.fetch('DB_NAME')}")
      # configuration.register_relation(Relations::Endpoints)
      container = ROM.container(configuration)
      container
    end
  end
end
