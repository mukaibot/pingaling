defmodule ApiWeb.EndpointController do
  use ApiWeb, :controller
  require Logger
  alias Api.Resources

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"name" => name}) do
    endpoint = Resources.get_endpoint!(name)
    render(conn, "show.json", endpoint: endpoint)
  end
end
