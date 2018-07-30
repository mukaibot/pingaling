defmodule Api.ResourcesTest do
  use Api.DataCase

  alias Api.Resources

  describe "endpoints" do
    alias Api.Resources.Endpoint

    @valid_attrs %{description: "some description", name: "some name", url: "some url"}
    @update_attrs %{description: "some updated description", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{description: nil, name: nil, next_check: nil, url: nil}

    def endpoint_fixture(attrs \\ %{}) do
      {:ok, date, 0} = DateTime.from_iso8601("2010-04-17 14:00:00.000000Z")
      {:ok, endpoint} =
        attrs
        |> Enum.into(Map.merge(@valid_attrs, %{next_check: date}))
        |> Resources.create_endpoint()

      endpoint
    end

    test "list_endpoints/0 returns all endpoints" do
      endpoint = endpoint_fixture()
      assert Resources.list_endpoints() == [endpoint]
    end

    test "get_endpoint!/1 returns the endpoint with given name" do
      endpoint = endpoint_fixture()
      assert Resources.get_endpoint!(endpoint.name) == endpoint
    end

    test "create_endpoint/1 with valid data creates a endpoint" do
      { :ok, date, 0} = DateTime.from_iso8601("2011-05-18 15:01:01.000000Z")
      assert {:ok, %Endpoint{} = endpoint} = Resources.create_endpoint(Map.merge(@valid_attrs, %{next_check: date}))
      assert endpoint.description == "some description"
      assert endpoint.name == "some name"
      assert endpoint.next_check == date
      assert endpoint.url == "some url"
    end

    test "create_endpoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_endpoint(@invalid_attrs)
    end

    test "update_endpoint/2 with valid data updates the endpoint" do
      endpoint = endpoint_fixture()
      { :ok, date, 0} = DateTime.from_iso8601("2011-05-18 15:01:01.000000Z")
      assert {:ok, endpoint} = Resources.update_endpoint(endpoint, Map.merge(@update_attrs, %{next_check: date}))
      assert %Endpoint{} = endpoint
      assert endpoint.description == "some updated description"
      assert endpoint.name == "some updated name"
      assert endpoint.next_check == date
      assert endpoint.url == "some updated url"
    end

    test "update_endpoint/2 with invalid data returns error changeset" do
      endpoint = endpoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_endpoint(endpoint, @invalid_attrs)
      assert endpoint == Resources.get_endpoint!(endpoint.name)
    end

    test "delete_endpoint/1 deletes the endpoint" do
      endpoint = endpoint_fixture()
      assert {:ok, %Endpoint{}} = Resources.delete_endpoint(endpoint)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_endpoint!(endpoint.name) end
    end

    test "change_endpoint/1 returns a endpoint changeset" do
      endpoint = endpoint_fixture()
      assert %Ecto.Changeset{} = Resources.change_endpoint(endpoint)
    end
  end
end
