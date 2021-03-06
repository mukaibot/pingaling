defmodule Api.CheckHandlers.SuccessHandler do
  @moduledoc false

  alias Api.Resources.HealthStatus
  alias Api.Repo

  def handle(endpoint) do
    %HealthStatus{}
    |> HealthStatus.changeset(%{status: :healthy, endpoint: endpoint})
    |> Repo.insert!()
  end
end
