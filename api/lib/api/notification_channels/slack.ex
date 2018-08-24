defmodule Api.NotificationChannels.Slack do
  require Logger
  require Poison
  require HTTPoison

  def send({:open, :endpoint, %{incident: incident, endpoint: endpoint, url: webhook_url}}) do
    message = Poison.encode!(%{text: "New alert for #{endpoint.name} (id=#{incident.id})"})
    Logger.info(message)
    HTTPoison.post(webhook_url, message)
  end

  def send({:auto_resolved, :endpoint, %{incident: incident, endpoint: endpoint, url: webhook_url}}) do
    message = Poison.encode!(%{text: "Incident for #{endpoint.name} (id=#{incident.id}) resolved by system"})
    Logger.info(message)
    HTTPoison.post(webhook_url, message)
  end
end
