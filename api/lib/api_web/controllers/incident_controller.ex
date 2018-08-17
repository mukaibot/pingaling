defmodule ApiWeb.IncidentController do
  use ApiWeb, :controller

  require Logger

  import Ecto.Query, warn: false
  alias Api.Repo
  alias Api.Resources.Incident

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    incidents = Repo.all(from i in Incident, order_by: i.updated_at, preload: [:endpoint])

    render(conn, "index.json", incidents: incidents)
  end
end
