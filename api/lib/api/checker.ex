defmodule Api.Checker do
  use GenServer
  alias Api.Resources.NextChecks
  alias Api.CheckHandlers.Endpoint
  require Logger

  @check_every 3_000 # seconds

  @doc """
  Start the checking loop
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
    endpoints_to_check = NextChecks.find()
    Enum.map(endpoints_to_check, fn ep -> check_endpoint(ep) end)

    {:noreply, %{last_run_at: :calendar.local_time()}}
  end

  defp check_endpoint(endpoint) do
    Logger.debug("Pinging #{endpoint.name} (id=#{endpoint.id}) on #{endpoint.url}")
    check_result = :httpc.request(to_charlist endpoint.url)
    NextChecks.set(endpoint)
    Endpoint.handle_result(check_result, endpoint)
  end
end
