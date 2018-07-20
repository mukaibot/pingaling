module Relations
  class Endpoints < ROM::Relation[:sql]
    schema(:endpoints, infer: true)
    struct_namespace '::Entities'
    auto_struct true
  end
end
