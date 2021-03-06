defmodule Api.Resources.Endpoint do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Resources.HealthStatus
  alias Api.Resources.Incident

  schema "endpoints" do
    field :description, :string
    field :name, :string
    field :next_check, :utc_datetime
    field :url, :string
    field :interval, :integer
    field :retries, :integer
    has_many :health_statuses, HealthStatus, on_delete: :delete_all
    has_many :incidents, Incident, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(endpoint, attrs) do
    endpoint
    |> cast(
         attrs,
         [
           :description,
           :interval,
           :name,
           :next_check,
           :retries,
           :url
         ]
       )
    |> validate_required([:name, :url])
    |> unique_constraint(:name)
  end
end
