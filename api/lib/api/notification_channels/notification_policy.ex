defmodule Api.NotificationChannels.NotificationPolicy do

  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Resources.Endpoint
  alias Api.NotificationChannels.ChannelConfiguration

  schema "notification_policies" do
    field :name, :string, null: false
    field :description, :string
    field :limit_sending, :boolean, default: false

    field :monday_start, :utc_datetime
    field :monday_end, :utc_datetime
    field :tuesday_start, :utc_datetime
    field :tuesday_end, :utc_datetime
    field :wednesday_start, :utc_datetime
    field :wednesday_end, :utc_datetime
    field :thursday_start, :utc_datetime
    field :thursday_end, :utc_datetime
    field :friday_start, :utc_datetime
    field :friday_end, :utc_datetime
    field :saturday_start, :utc_datetime
    field :saturday_end, :utc_datetime
    field :sunday_start, :utc_datetime
    field :sunday_end, :utc_datetime

    belongs_to(:endpoint, Endpoint)
    belongs_to(:notification_channel, ChannelConfiguration, foreign_key: :channel_id)

    timestamps(type: :utc_datetime)
  end

  def changeset(notification_policy, attrs) do
    notification_policy
    |> cast(attrs, [:name])
    |> cast_assoc(:endpoint)
    |> cast_assoc(:notification_channel)
    |> validate_required(:name)
    |> unique_constraint(:name)
  end
end
