defmodule ApiWeb.IncidentControllerTest do
  use ApiWeb.ConnCase do
    import Api.Factory
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "getting all incidents" do
    test "ordered by least to most recent", %{conn: conn} do
      ep = insert(:endpoint)
      incident1 = insert(:incident, %{endpoint: ep})
      insert(:incident, %{endpoint: ep})
      incident3 = insert(:incident, %{endpoint: ep})

      conn = conn
             |> get(incident_path(conn, :index))
             |> doc

      assert json_response(conn, 200)["data"]
             |> Enum.count >= 3
      assert json_response(conn, 200)["data"]
             |> List.first
             |> Map.get("name") == incident1.endpoint.name
      assert json_response(conn, 200)["data"]
             |> List.last
             |> Map.get("name") == incident3.endpoint.name
    end
  end
end
