defmodule Api.Repo.Migrations.CreateNotificationPolicies do
  use Ecto.Migration

  def change do
    create table(:notification_policies) do
      add :name, :string, null: false
      add :description, :string
      add :endpoint_id, references(:endpoints), null: false
      add :channel_id, references(:notification_channels), null: false
      add :limit_sending, :bool, default: false

      add :monday_start, :utc_datetime
      add :monday_end, :utc_datetime
      add :tuesday_start, :utc_datetime
      add :tuesday_end, :utc_datetime
      add :wednesday_start, :utc_datetime
      add :wednesday_end, :utc_datetime
      add :thursday_start, :utc_datetime
      add :thursday_end, :utc_datetime
      add :friday_start, :utc_datetime
      add :friday_end, :utc_datetime
      add :saturday_start, :utc_datetime
      add :saturday_end, :utc_datetime
      add :sunday_start, :utc_datetime
      add :sunday_end, :utc_datetime

      timestamps(type: :timestamptz)
    end

    unique_index(:notification_channels, :name)
  end
end
