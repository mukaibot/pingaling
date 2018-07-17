require 'rom-repository'

module Repositories
  class Endpoints < ROM::Repository[:endpoints]
    commands :create, update: :by_pk, delete: :by_pk
  end
end
