defmodule ApiWeb.ManifestController do
  use ApiWeb, :controller

  alias Api.Resources.Manifest

  action_fallback ApiWeb.FallbackController

  def apply(conn, %{"manifest" => params}) do
    {status, result } = Manifest.apply(params)

    conn
    |> put_status(status)
    |> render("apply.json", result: result)
  end
end
