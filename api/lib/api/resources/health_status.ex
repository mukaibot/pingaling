defmodule Api.Resources.HealthStatus do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Resources.Endpoint

  schema "health_statuses" do
    field :status, HealthStatusEnum
    field :type, CheckTypeEnum, default: :endpoint
    belongs_to :endpoint, Endpoint

    timestamps()
  end

  @doc false
  def changeset(health_status, attrs) do
    health_status
    |> cast(attrs, [:status])
    |> validate_required([:status, :endpoint])
  end
end
