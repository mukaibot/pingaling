defmodule ApiWeb.EndpointController do
  use ApiWeb, :controller
  require Logger
  alias Api.Resources
  alias Api.Resources.HealthSummariser

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"name" => name}) do
    endpoint = Resources.get_endpoint!(name)
    [health|_] = HealthSummariser.recent_health_statuses(endpoint, 1)

    render(conn, "show.json", endpoint: Map.merge(endpoint, %{health_summary: health}))
  end

  def delete(conn, %{"name" => name}) do
    endpoint = Resources.get_endpoint!(name)
    Resources.delete_endpoint(endpoint)

    json(conn, %{message: "Deleted endpoint #{endpoint.name}"})
  end
end
