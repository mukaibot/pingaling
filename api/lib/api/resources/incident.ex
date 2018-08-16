defmodule Api.Resources.Incident do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Resources.Endpoint

  schema "incidents" do
    belongs_to :endpoint, Endpoint
    field :status, IncidentStatusEnum, default: :open

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(incident, attrs) do
    incident
    |> cast(attrs, [:status])
    |> validate_required([:status])
    |> foreign_key_constraint(:endpoint)
  end
end
