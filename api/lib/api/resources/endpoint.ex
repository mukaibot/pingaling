defmodule Api.Resources.Endpoint do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Resources.HealthStatus

  schema "endpoints" do
    field :description, :string
    field :name, :string
    field :next_check, :utc_datetime
    field :url, :string
    has_many :health_statuses, HealthStatus

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(endpoint, attrs) do
    endpoint
    |> cast(attrs, [:name, :url, :description, :next_check])
    |> validate_required([:name, :url])
    |> unique_constraint(:name)
  end
end
