defmodule Api.Resources.NextChecks do
  @moduledoc """
  Finds resources that are ready to be checked
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  require Logger

  alias Api.Resources.Endpoint

  def find() do
    query = from ep in Endpoint,
                 where: is_nil(ep.next_check),
                 or_where: ep.next_check < fragment("now()")

    Repo.all(query)
  end

  def set(endpoint) do
    interval = endpoint.interval
    {:ok, next} = DateTime.from_unix(DateTime.to_unix(DateTime.utc_now()) + interval)

    Logger.debug("Setting next check for #{endpoint.name} from #{endpoint.next_check} to #{next}")

    endpoint
    |> Endpoint.changeset(%{next_check: next})
    |> Repo.update!()
  end
end
