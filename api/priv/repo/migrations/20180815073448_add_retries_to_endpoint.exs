defmodule Api.Repo.Migrations.AddRetriesToEndpoint do
  use Ecto.Migration

  def change do
    alter table("endpoints") do
      add :retries, :int, default: 2
    end
    create constraint("endpoints", :retries_must_be_positive, check: "retries >= 0")
    create constraint("endpoints", :interval_must_be_positive, check: "interval > 0")
  end
end
