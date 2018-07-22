class EndpointRepository < Hanami::Repository
  def by_name(name)
    endpoints.where(name: name)
  end
end
