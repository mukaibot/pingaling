defmodule ApiWeb.HealthSummaryControllerTest do
  use ApiWeb.ConnCase do
    import Api.Factory
  end

  alias Api.Resources

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "gets the complete summary", %{conn: conn} do
      endpoints = insert_pair(:endpoint)
      [head | tail] = endpoints
      insert(:health_status, %{endpoint: head})

      conn = get conn, health_summary_path(conn, :index)

      assert json_response(conn, 200)["data"] |> Enum.count >= 2
    end
  end
end
