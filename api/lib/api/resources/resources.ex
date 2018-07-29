defmodule Api.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Resources.Endpoint

  @doc """
  Returns the list of endpoints.

  ## Examples

      iex> list_endpoints()
      [%Endpoint{}, ...]

  """
  def list_endpoints do
    Repo.all(Endpoint)
  end

  @doc """
  Gets a single endpoint.

  Raises `Ecto.NoResultsError` if the Endpoint does not exist.

  ## Examples

      iex> get_endpoint!(123)
      %Endpoint{}

      iex> get_endpoint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_endpoint!(name) do
#    Repo.get!(Endpoint, name)
    Repo.get_by!(Endpoint, name: name)
  end

  @doc """
  Creates a endpoint.

  ## Examples

      iex> create_endpoint(%{field: value})
      {:ok, %Endpoint{}}

      iex> create_endpoint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_endpoint(attrs \\ %{}) do
    %Endpoint{}
    |> Endpoint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a endpoint.

  ## Examples

      iex> update_endpoint(endpoint, %{field: new_value})
      {:ok, %Endpoint{}}

      iex> update_endpoint(endpoint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_endpoint(%Endpoint{} = endpoint, attrs) do
    endpoint
    |> Endpoint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Endpoint.

  ## Examples

      iex> delete_endpoint(endpoint)
      {:ok, %Endpoint{}}

      iex> delete_endpoint(endpoint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_endpoint(%Endpoint{} = endpoint) do
    Repo.delete(endpoint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking endpoint changes.

  ## Examples

      iex> change_endpoint(endpoint)
      %Ecto.Changeset{source: %Endpoint{}}

  """
  def change_endpoint(%Endpoint{} = endpoint) do
    Endpoint.changeset(endpoint, %{})
  end

  def get_endpoint(name) do
    Repo.one(Endpoint, name: name)
  end
end
