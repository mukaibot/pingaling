defmodule ApiWeb.EndpointController do
  use ApiWeb, :controller

  require Logger

  alias Api.Resources
  alias Api.Resources.Endpoint

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    endpoints = Resources.list_endpoints()
    render(conn, "index.json", endpoints: endpoints)
  end

  def show(conn, %{"name" => name}) do
    endpoint = Resources.get_endpoint!(name)
    render(conn, "show.json", endpoint: endpoint)
  end
end
