defmodule ApiWeb.NotificationPolicyView do
  use ApiWeb, :view
  alias ApiWeb.NotificationPolicyView

  def render("index.json", %{notification_policies: notification_policies}) do
    %{data: render_many(notification_policies, NotificationPolicyView, "notification_policy.json")}
  end

  def render("show.json", %{notification_policy: notification_policy}) do
    %{data: render_one(notification_policy, NotificationPolicyView, "notification_policy.json")}
  end

  def render("notification_policy.json", %{notification_policy: notification_policy}) do
    %{
      name: notification_policy.name,
      type: notification_policy.notification_channel.type,
      endpoint: notification_policy.endpoint.name,
      channel: notification_policy.notification_channel.name,
      updated_at: notification_policy.updated_at
    }
  end
end
