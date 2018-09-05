defmodule Api.Repo do
  use Ecto.Repo, otp_app: :api

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    username = System.get_env("POSTGRES_USER") || "postgres"
    password = System.get_env("POSTGRES_PASS") || "postgres"
    database = System.get_env("POSTGRES_DB") || "pingaling"
    hostname = System.get_env("POSTGRES_HOST") || "localhost"
    url      = System.get_env("DATABASE_URL") || "postgresql://#{username}@#{hostname}/#{database}"

    {
      :ok,
      opts
      |> Keyword.put(:url, url)
    }
  end
end
