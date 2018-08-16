defmodule Api.Repo.Migrations.CreateIncidents do
  use Ecto.Migration

  def change do
    create table(:incidents) do
      add :endpoint_id, references(:endpoints), null: false
      add :status, :incident_status, null: false
      timestamps(type: :timestamptz)
    end
  end
end
