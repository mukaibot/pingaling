defmodule ApiWeb.NotificationChannelController do
  use ApiWeb, :controller

  require Logger

  import Ecto.Query, warn: false
  alias Api.Repo
  alias Api.NotificationChannels.ChannelConfiguration

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    notification_channels = Repo.all(from c in ChannelConfiguration, order_by: c.name)

    render(conn, "index.json", notification_channels: notification_channels)
  end

  def delete(conn, %{"name" => name}) do
    channel = Repo.get_by!(ChannelConfiguration, name: name)
    Repo.delete(channel)

    json(conn, %{message: "Deleted notification channel #{channel.name}"})
  end
end
