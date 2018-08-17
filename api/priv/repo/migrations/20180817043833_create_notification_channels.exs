defmodule Api.Repo.Migrations.CreateNotificationChannels do
  use Ecto.Migration

  def up do
    NotficationChannelTypeEnum.create_type
    create table(:notification_channels) do
      add :name, :string, null: false
      add :type, :notification_channel_type, null: false
      add :data, :map, null: false

      timestamps(type: :timestamptz)
    end
  end

  def down do
    drop table(:notification_channels)
    NotficationChannelTypeEnum.drop_type
  end
end
