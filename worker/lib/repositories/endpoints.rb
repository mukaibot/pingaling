require 'rom-repository'
require_relative '../relations/endpoints'

module Repositories
  class Endpoints < ROM::Repository[:endpoints]
    commands :create, update: :by_pk, delete: :by_pk

    def all
      endpoints
    end

    def ready_for_checking
      endpoints.where(Sequel.lit("next_check > ?", Time.now.utc))
    end

    def by_id(id)
      endpoints.by_pk(id).one!
    end
  end
end
