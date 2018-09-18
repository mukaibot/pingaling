defmodule Api.NotificationChannels do
  @moduledoc """
  The Resources context.
  """

  alias Api.Repo
  alias Api.NotificationChannels.ChannelConfiguration

  @doc """
  Gets a single notification channel.

  Raises `Ecto.NoResultsError` if the Notification Channel does not exist.

  ## Examples

      iex> get_notification_channel!("slackbar")
      %ChannelConfiguration{}

      iex> get_notification_channel!("unknown")
      ** (Ecto.NoResultsError)

  """
  def get_notification_channel!(name) do
    Repo.get_by!(ChannelConfiguration, name: name)
  end
end