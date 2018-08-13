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
    |> cast(attrs, [:status, :endpoint_id])
    |> validate_required([:status])
    |> foreign_key_constraint(:endpoint_id)
#    |> validate_exactly_one_check(:endpoint_id)
  end

  defp validate_exactly_one_check(changeset, field, options \\ []) do
    validate_change(
      changeset,
      field,
      fn :endpoint_id, term ->
        case is_nil term do
          true -> [{:endpoint_id, options[:message] || "Must have endpoint_id"}]
          false -> []
        end
      end
    )
  end
end
