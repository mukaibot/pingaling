defmodule Api.IncidentManagement.IncidentCreator do
  use GenServer

  @moduledoc false

  @check_every 3_000 # seconds

  import Ecto.Query, warn: false
  alias Api.Repo
  require Logger

  alias Api.Resources.HealthSummariser
  alias Api.Resources.Incident

  @doc """
  Start the loop to create incidents for unhealthy systems
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

    create_incidents()

    {:noreply, %{last_run_at: :calendar.local_time()}}
  end

  def create_incidents() do
    HealthSummariser.unhealthy_endpoints()
    |> Enum.map(fn unhealthy_ep -> create_incident_if_required(unhealthy_ep) end)
  end

  defp create_incident_if_required(endpoint) do
    case Repo.one(
           from i in Incident,
           where: [endpoint_id: ^endpoint.id, status: "open"],
           select: count(i.id)
         ) do
      0 ->
        Logger.debug("******")
        Logger.debug("Creating incident for #{endpoint.name}")
        Logger.debug("******")

        %Incident{}
        |> Incident.changeset(%{status: :open})
        |> Ecto.Changeset.put_assoc(:endpoint, endpoint)
        |> Repo.insert()

      1 ->
        Logger.debug("")
        Logger.debug("******")
        Logger.debug("Incident already open for #{endpoint.name}")
        Logger.debug("******")
        Logger.debug("")
    end
  end
end
