defmodule Api.Repo.Migrations.AddIntervalToEndpoints do
  use Ecto.Migration

  def change do
    alter table("endpoints") do
      add :interval, :int, default: 30
    end
  end
end
