defmodule Api.Resources.HealthSummariser do
  @moduledoc """
  Gets the current health of all resources
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Resources.Endpoint
  alias Api.Resources.HealthStatus

  def find() do
    query = from ep in Endpoint,
                 join: health_statuses in HealthStatus,
                 on: health_statuses.endpoint_id == ep.id,
                 select: %{
                   :name => ep.name,
                   :status => health_statuses.status,
                   :type => health_statuses.type,
                   :updated_at => health_statuses.updated_at
                 },
                 order_by: health_statuses.updated_at

    Repo.all(query)
  end
end
