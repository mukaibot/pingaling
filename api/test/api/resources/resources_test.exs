defmodule Api.ResourcesTest do
  use Api.DataCase
  import Api.Factory
  alias Api.Resources

  describe "endpoints" do
    alias Api.Resources.Endpoint

    @valid_attrs %{description: "some description", name: "some name", url: "some url"}
    @update_attrs %{description: "some updated description", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{description: nil, name: nil, next_check: nil, url: nil}

    test "list_endpoints/0 returns all endpoints" do
      endpoint = insert(:endpoint)
      [first | _] = Resources.list_endpoints()
      assert first.id == endpoint.id
    end

    test "get_endpoint!/1 returns the endpoint with given name" do
      endpoint = insert(:endpoint)
      assert Resources.get_endpoint!(endpoint.name).id == endpoint.id
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
      endpoint = insert(:endpoint)
      { :ok, date, 0} = DateTime.from_iso8601("2011-05-18 15:01:01.000000Z")
      assert {:ok, endpoint} = Resources.update_endpoint(endpoint, Map.merge(@update_attrs, %{next_check: date}))
      assert %Endpoint{} = endpoint
      assert endpoint.description == "some updated description"
      assert endpoint.name == "some updated name"
      assert endpoint.next_check == date
      assert endpoint.url == "some updated url"
    end

    test "update_endpoint/2 with invalid data returns error changeset" do
      insert(:endpoint)
      endpoint = Repo.one(Endpoint)
      assert {:error, %Ecto.Changeset{}} = Resources.update_endpoint(endpoint, @invalid_attrs)
      assert endpoint == Resources.get_endpoint!(endpoint.name)
    end

    test "delete_endpoint/1 deletes the endpoint and health statuses" do
      endpoint = insert(:endpoint)
      assert 1 == Repo.one(from hs in "health_statuses", select: count(hs.id))
      assert {:ok, %Endpoint{}} = Resources.delete_endpoint(endpoint)
      assert 0 == Repo.one(from hs in "health_statuses", select: count(hs.id))
      assert_raise Ecto.NoResultsError, fn -> Resources.get_endpoint!(endpoint.name) end
    end

    test "change_endpoint/1 returns a endpoint changeset" do
      endpoint = insert(:endpoint)
      assert %Ecto.Changeset{} = Resources.change_endpoint(endpoint)
    end
  end
end
