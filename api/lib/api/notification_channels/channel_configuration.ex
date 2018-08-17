defmodule Api.NotificationChannels.ChannelConfiguration do

  use Ecto.Schema
  import Ecto.Changeset

  schema "notification_channels" do
    field :name, :string, null: false
    field :type, NotficationChannelTypeEnum, null: false
    field :data, :map, null: false

    timestamps(type: :utc_datetime)
  end
end
