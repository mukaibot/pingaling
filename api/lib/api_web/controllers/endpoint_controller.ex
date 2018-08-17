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
end
