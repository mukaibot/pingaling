defmodule Api.Resources.EndpointHealthStatus do
  use Ecto.Schema

  schema "endpoint_health_status" do
    field :name, :string
    field :status, HealthStatusEnum
    field :type, CheckTypeEnum, default: :endpoint
    field :url, :string
    field :updated_at, :utc_datetime
  end
end
