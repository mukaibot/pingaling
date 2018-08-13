defmodule Api.Resources.HealthSummariser do
  @moduledoc """
  Gets the current health of all resources
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Resources.EndpointHealthStatus

    @query ~S"""
    SELECT
      name,
      status,
      most_recent_health_status.type,
      most_recent_health_status.inserted_at
    FROM endpoints
    JOIN (
      SELECT DISTINCT ON (endpoint_id)
        endpoint_id,
        status,
        type,
        inserted_at
      FROM health_statuses
      ORDER BY endpoint_id, inserted_at DESC
    ) as most_recent_health_status
    ON most_recent_health_status.endpoint_id = endpoints.id
    """
  def find() do
    result = Ecto.Adapters.SQL.query!(Repo, @query, [])
    Enum.map(result.rows, &Repo.load(EndpointHealthStatus, {result.columns, &1}))
  end
end
