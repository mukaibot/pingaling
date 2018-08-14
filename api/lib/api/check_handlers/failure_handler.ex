defmodule Api.CheckHandlers.FailureHandler do
  @moduledoc false

  alias Api.Resources.HealthStatus
  alias Api.Repo

  def handle(endpoint) do
    %HealthStatus{}
    |> HealthStatus.changeset(%{status: :unhealthy, endpoint: endpoint})
    |> Repo.insert!()
  end
end
