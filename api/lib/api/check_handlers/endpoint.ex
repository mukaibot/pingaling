defmodule Api.CheckHandlers.Endpoint do
  @moduledoc false

  alias Api.CheckHandlers.SuccessHandler
  alias Api.CheckHandlers.FailureHandler

  require Logger

  def handle_result({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body}}, endpoint) do
    SuccessHandler.handle(endpoint)
    Logger.debug("OK #{endpoint.name}")
  end

  def handle_result({:error, {:failed_connect, _params}}, endpoint) do
    FailureHandler.handle(endpoint)
    Logger.debug("FAIL #{endpoint.name}")
  end

  def handle_result(_, endpoint) do
    FailureHandler.handle(endpoint)
    Logger.debug("FAIL #{endpoint.name}")
  end
end
