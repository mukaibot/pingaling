defmodule Api.Repo.Migrations.CreateHealthStatuses do
  use Ecto.Migration

  def up do
    HealthStatusEnum.create_type
    CheckTypeEnum.create_type
    create table(:health_statuses) do
      add :status, :health_status, null: false
      add :type, :check_type, null: false
      add :endpoint_id, references(:endpoints, on_delete: :delete_all), null: false

      timestamps(type: :timestamptz)
    end
  end

  def down do
    drop table(:health_statuses)
    HealthStatusEnum.drop_type
    CheckTypeEnum.drop_type
  end
end
