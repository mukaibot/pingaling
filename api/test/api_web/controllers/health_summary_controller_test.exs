defmodule ApiWeb.HealthSummaryControllerTest do
  use ApiWeb.ConnCase do
    import Api.Factory
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "returning health summaries" do
    test "for all endpoints", %{conn: conn} do
      endpoints = insert_pair(:endpoint)
      [head | _] = endpoints
      insert(:health_status, %{endpoint: head})

      result = conn
               |> get(health_summary_path(conn, :index))
               |> doc

      assert json_response(result, 200)["data"]
             |> Enum.count >= 2
    end
  end
end
