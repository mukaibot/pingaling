defmodule Api.CheckHandlers.EndpointChecker do
  @moduledoc false

  alias Api.CheckHandlers.SuccessHandler
  alias Api.CheckHandlers.FailureHandler
  alias Api.Resources.HealthSummariser
  alias Api.Resources.NextChecks

  require Logger

  @doc """
  Pings an endpoint to see if it's healthy or not
  """
  def check(endpoint) do
    Logger.debug("Pinging #{endpoint.name} (id=#{endpoint.id}) on #{endpoint.url}")
    check_result = :httpc.request(to_charlist endpoint.url)
    NextChecks.set(endpoint)

    handle_result(check_result, endpoint)
  end

  # Get endpoint retries worth of health statuses. If it's now healthy, autoresolve the incident
  defp handle_result({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body}}, endpoint) do
    SuccessHandler.handle(endpoint)
    Logger.debug("OK #{endpoint.name}")
  end

  # Create incident if it's unhealthy after endpoint.retries worth of health statuses
  defp handle_result({:error, {:failed_connect, _params}}, endpoint) do
    FailureHandler.handle(endpoint)
    Logger.debug("FAIL #{endpoint.name}")
  end
end
