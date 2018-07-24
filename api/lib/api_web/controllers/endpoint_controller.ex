defmodule ApiWeb.EndpointController do
  use ApiWeb, :controller

  alias Api.Resources
  alias Api.Resources.Endpoint

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    endpoints = Resources.list_endpoints()
    render(conn, "index.json", endpoints: endpoints)
  end

  def show(conn, %{"id" => id}) do
    endpoint = Resources.get_endpoint!(id)
    render(conn, "show.json", endpoint: endpoint)
  end
end
