defmodule Api.Repo.Migrations.AddDescriptionToNotificationChannel do
  use Ecto.Migration

  def change do
    alter table(:notification_channels) do
      add :description, :string
    end
  end
end
