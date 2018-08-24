defmodule Api.NotificationChannels.NotificationDispatcher do
  import Ecto.Query, warn: false

  require Logger

  alias Api.Repo
  alias Api.NotificationChannels.NotificationPolicy
  alias Api.NotificationChannels.Slack

  def dispatch({status, incident, endpoint}) do
    notification_policies = Repo.all(
      from np in NotificationPolicy,
      where: np.endpoint_id == ^endpoint.id,
      preload: [:endpoint, :notification_channel]
    )

    notification_policies |> Enum.map(fn np ->
      if np.limit_sending == true do
        Logger.debug("This is where we would check if the time is appropriate to send")
      else
        type = np.notification_channel.type
        cond do
          type == :slack ->
            params = %{
              incident: incident,
              endpoint: endpoint,
              url: np.notification_channel.data["webhook_url"]
            }
            Slack.send({status, :endpoint, params})
        end
      end
    end)
  end
end
