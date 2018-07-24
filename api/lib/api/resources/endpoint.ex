defmodule Api.Resources.Endpoint do
  use Ecto.Schema
  import Ecto.Changeset


  schema "endpoints" do
    field :description, :string
    field :name, :string
    field :next_check, :naive_datetime
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(endpoint, attrs) do
    endpoint
    |> cast(attrs, [:name, :url, :description, :next_check])
    |> validate_required([:name, :url])
    |> unique_constraint(:name)
  end
end
