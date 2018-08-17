defmodule ApiWeb.NotificationChannelView do
  use ApiWeb, :view
  alias ApiWeb.NotificationChannelView

  def render("index.json", %{notification_channels: notification_channels}) do
    %{data: render_many(notification_channels, NotificationChannelView, "notification_channel.json")}
  end

  def render("show.json", %{notification_channel: notification_channel}) do
    %{data: render_one(notification_channel, NotificationChannelView, "notification_channel.json")}
  end

  def render("notification_channel.json", %{notification_channel: notification_channel}) do
    %{
      name: notification_channel.name,
      type: notification_channel.type,
      updated_at: notification_channel.updated_at
    }
  end
end
