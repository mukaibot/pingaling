# module Entities
  class Endpoint < ROM::Struct
    def ==(other_thing)
      self.to_h == other_thing.to_h
    end

    def throbble
      puts "boo"
    end
  end
# end
