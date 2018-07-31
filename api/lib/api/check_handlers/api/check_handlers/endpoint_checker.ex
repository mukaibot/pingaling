defmodule Api.CheckHandlers.EndpointChecker do
  @moduledoc false

  require Logger

  def check({name, id, url}) do
    Logger.debug("Pinging #{name} (#{id}) on #{url}")
  end
end
