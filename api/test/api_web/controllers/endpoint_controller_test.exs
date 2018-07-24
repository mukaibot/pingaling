defmodule ApiWeb.EndpointControllerTest do
  use ApiWeb.ConnCase

  alias Api.Resources

  @create_attrs %{
    description: "some description",
    name: "some-name",
    next_check: ~N[2010-04-17 14:00:00.000000],
    url: "http://my-service/healthz"
  }

  def fixture(:endpoint) do
    {:ok, endpoint} = Resources.create_endpoint(@create_attrs)
    endpoint
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all endpoints", %{conn: conn} do
      conn = get conn, endpoint_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "show" do
    test "gets a specific endpoint by name", %{conn: conn} do
      endpoint = create_endpoint("")
      { :ok, [ endpoint: %{ name: name } ] } = endpoint

      conn = get conn, endpoint_path(conn, :show, name)
      assert json_response(conn, 200)["data"] == %{
               "name" => "some-name",
               "description" => "some description",
               "next_check" => "2010-04-17T14:00:00.000000",
               "url" => "http://my-service/healthz"
             }
    end
  end

  defp create_endpoint(_) do
    endpoint = fixture(:endpoint)
    {:ok, endpoint: endpoint}
  end
end
