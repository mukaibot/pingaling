defmodule ApiWeb.NotificationPolicyController do
  use ApiWeb, :controller

  require Logger

  import Ecto.Query, warn: false
  alias Api.Repo
  alias Api.NotificationChannels.NotificationPolicy

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    notification_policies = Repo.all(from np in NotificationPolicy, order_by: np.name, preload: [:endpoint, :notification_channel])

    render(conn, "index.json", notification_policies: notification_policies)
  end

  def delete(conn, %{"name" => name}) do
    policy = Repo.get_by!(NotificationPolicy, name: name)
    Repo.delete(policy)

    json(conn, %{message: "Deleted notification policy #{policy.name}"})
  end
end
