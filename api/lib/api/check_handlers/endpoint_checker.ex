defmodule Api.CheckHandlers.EndpointChecker do
  @moduledoc false

  alias Api.CheckHandlers.SuccessHandler

  require Logger

  def check({name, id, url}) do
    Logger.debug("Pinging #{name} (id=#{id}) on #{url}")
    check_result = :httpc.request(to_charlist url)

    handle_result(check_result, name, id)
  end

  defp handle_result({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body}}, name, id) do
    SuccessHandler.handle(id)
    Logger.debug("OK #{name}")
  end

  defp handle_result({:error, {:failed_connect, _params}}, name, _id) do
    Logger.debug("FAIL #{name}")
  end
end
