defmodule Api.Repo.Migrations.NotificationNameMustBeUnique do
  use Ecto.Migration

  def change do
    unique_index(:notification_channels, :name)
  end
end
