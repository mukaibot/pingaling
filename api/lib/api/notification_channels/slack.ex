defmodule Api.NotificationChannels.Slack do
  require Logger
  require Poison
  require HTTPoison

  @slack_name "Pingaling Monitoring"

  def send({:open, :endpoint, %{incident: incident, endpoint: endpoint, url: webhook_url}}) do
    message = Poison.encode!(%{username: @slack_name, text: ":fire: New alert for #{endpoint.name} (id=#{incident.id}). #{endpoint.name} is UNHEALTHY"})
    Logger.info(message)
    HTTPoison.post(webhook_url, message)
  end

  def send({:auto_resolved, :endpoint, %{incident: incident, endpoint: endpoint, url: webhook_url}}) do
    message = Poison.encode!(%{username: @slack_name, text: ":green: Incident for #{endpoint.name} (id=#{incident.id}) resolved by system"})
    Logger.info(message)
    HTTPoison.post(webhook_url, message)
  end
end
