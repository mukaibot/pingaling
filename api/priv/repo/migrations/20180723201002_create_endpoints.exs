defmodule Api.Repo.Migrations.CreateEndpoints do
  use Ecto.Migration

  def change do
    create table(:endpoints) do
      add :name, :string, null: false
      add :url, :string, null: false
      add :description, :text
      add :next_check, :timestamptz

      timestamps(type: :timestamptz)
    end

    create unique_index(:endpoints, [:name])
  end
end
