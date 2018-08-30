defmodule ApiWeb.EndpointControllerTest do
  use ApiWeb.ConnCase
  import Api.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "getting an endpoint" do
    test "by name", %{conn: conn} do
      endpoint = insert(:endpoint)

      conn = conn
             |> get(endpoint_path(conn, :show, endpoint.name))
             |> doc

      assert json_response(conn, 200)["data"] == %{
               "name" => endpoint.name,
               "description" => nil,
               "next_check" => endpoint.next_check,
               "url" => endpoint.url
             }
    end
  end

  describe "deleting an endpoint" do
    test "it deletes the endpoint", %{conn: conn} do
      endpoint = insert(:endpoint)
      insert(:incident, endpoint: endpoint)

      conn = delete(conn, endpoint_path(conn, :delete, endpoint.name))
             |> doc

      assert json_response(conn, 200) == %{"message" => "Deleted endpoint #{endpoint.name}" }
    end
  end
end
