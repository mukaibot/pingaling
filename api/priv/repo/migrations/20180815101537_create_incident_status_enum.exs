defmodule Api.Repo.Migrations.CreateIncidentStatusEnum do
  use Ecto.Migration

  def up do
    IncidentStatusEnum.create_type
  end

  def down do
    IncidentStatusEnum.drop_type
  end
end
