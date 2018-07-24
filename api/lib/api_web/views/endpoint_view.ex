defmodule ApiWeb.EndpointView do
  use ApiWeb, :view
  alias ApiWeb.EndpointView

  def render("index.json", %{endpoints: endpoints}) do
    %{data: render_many(endpoints, EndpointView, "endpoint.json")}
  end

  def render("show.json", %{endpoint: endpoint}) do
    %{data: render_one(endpoint, EndpointView, "endpoint.json")}
  end

  def render("endpoint.json", %{endpoint: endpoint}) do
    %{id: endpoint.id,
      name: endpoint.name,
      url: endpoint.url,
      description: endpoint.description,
      next_check: endpoint.next_check}
  end
end
