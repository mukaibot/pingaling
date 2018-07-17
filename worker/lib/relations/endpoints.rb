module Relations
  class Endpoints < ROM::Relation[:sql]
    schema(:endpoints, infer: true)
  end
end
