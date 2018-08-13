defmodule ApiWeb.HealthSummaryController do
  use ApiWeb, :controller

  require Logger

  alias Api.Resources.HealthSummariser

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    summaries = HealthSummariser.find()
    render(conn, "index.json", health_summaries: summaries)
  end
end
