defmodule Api.IncidentManagement.IncidentAutoResolver do
  use GenServer

  @moduledoc false

  @check_every 3_000 # seconds

  import Ecto.Query, warn: false
  alias Api.Repo
  require Logger

  alias Api.Resources.HealthSummariser
  alias Api.Resources.Incident

  @doc """
  Start the loop to resolve incidents when endpoints are healthy
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.send_after(self(), :work, @check_every)
    {:ok, %{last_run_at: nil}}
  end

  def handle_info(:work, _state) do
    Process.send_after(self(), :work, @check_every)

    resolve_incidents()

    {:noreply, %{last_run_at: :calendar.local_time()}}
  end

  def resolve_incidents() do
    Repo.all(
      from i in Incident,
      where: [
        status: "open"
      ],
      preload: [:endpoint]
    )
    |> Enum.map(fn incident -> resolve_incident_if_healthy(incident) end)
  end

  defp resolve_incident_if_healthy(incident) do
    [last_health | _] = HealthSummariser.recent_health_statuses(incident.endpoint, 1)

    if last_health == :healthy do
      Logger.debug("")
      Logger.debug("******")
      Logger.debug("Resolving incident for #{incident.endpoint.name}")
      Logger.debug("******")
      Logger.debug("")

      incident
      |> Incident.changeset(%{status: :auto_resolved})
      |> Ecto.Changeset.put_assoc(:endpoint, incident.endpoint)
      |> Repo.update!()
    end
  end
end
