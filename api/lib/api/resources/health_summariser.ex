defmodule Api.Resources.HealthSummariser do
  @moduledoc """
  Gets the current health of all resources
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Resources.Endpoint
  alias Api.Resources.HealthStatus
  alias Api.Resources.EndpointHealthStatus

  @query ~S"""
  SELECT
    name,
    status,
    most_recent_health_status.type,
    url,
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

  def recent_health_statuses(endpoint) do
    recent_health_statuses(endpoint, endpoint.retries)
  end

  def recent_health_statuses(endpoint, limit) do
    Repo.all(
      from health_status in HealthStatus,
      where: health_status.endpoint_id == ^endpoint.id,
      order_by: [
        desc: health_status.updated_at
      ],
      limit: ^limit,
      select: health_status.status
    )
    |> Enum.reverse
  end

  def unhealthy_endpoints() do
    Repo.all(Endpoint)
    |> Enum.filter(
         fn ep ->
           recent_health_statuses(ep)
           |> Enum.uniq
           |> Enum.all?(fn status -> status == :unhealthy end)
         end
       )
  end
end
