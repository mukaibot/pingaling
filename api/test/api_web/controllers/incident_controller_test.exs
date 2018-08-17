defmodule ApiWeb.IncidentControllerTest do
  use ApiWeb.ConnCase do
    import Api.Factory
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "gets all incidents most recent last", %{conn: conn} do
      ep = insert(:endpoint)
      incident1 = insert(:incident, %{endpoint: ep})
      insert(:incident, %{endpoint: ep})
      incident3 = insert(:incident, %{endpoint: ep})

      conn = get conn, incident_path(conn, :index)

      assert json_response(conn, 200)["data"] |> Enum.count >= 3
      assert json_response(conn, 200)["data"] |> List.first |> Map.get("name") == incident1.endpoint.name
      assert json_response(conn, 200)["data"] |> List.last |> Map.get("name") == incident3.endpoint.name
    end
  end
end
