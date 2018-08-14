defmodule Api.Resources.NextChecks do
  @moduledoc """
  Finds resources that are ready to be checked
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Resources.Endpoint

  def find() do
    query = from ep in Endpoint,
      where: is_nil(ep.next_check),
      or_where: ep.next_check < fragment("now()")

    Repo.all(query)
  end
end
