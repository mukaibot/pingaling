module Actions
  class Base
    attr_reader :gw, :outputter

    def initialize
      @gw = Factory.gateway
      @outputter = Factory.outputter
    end

    def padding
      [0, 3, 0, 0]
    end

    def to_collection(thing)
      if Hash === thing
        [thing]
      else
        thing
      end
    end
  end
end
