defmodule Api.Resources.HealthStatus do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Resources.Endpoint

  schema "health_statuses" do
    field :status, HealthStatusEnum
    field :type, CheckTypeEnum, default: :endpoint
    belongs_to :endpoint, Endpoint

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(health_status, attrs) do
    health_status
    |> cast(attrs, [:status])
    |> put_assoc(:endpoint, attrs.endpoint)
    |> validate_required([:status])
    |> foreign_key_constraint(:endpoint_id)
  end
end
