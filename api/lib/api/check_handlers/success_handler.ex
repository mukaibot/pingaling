defmodule Api.CheckHandlers.SuccessHandler do
  @moduledoc false

  alias Api.Resources.HealthStatus
  alias Api.Repo

  def handle(id) do
    %HealthStatus{}
    |> HealthStatus.changeset(%{status: :healthy, endpoint_id: id})
    |> Repo.insert!()
  end
end
