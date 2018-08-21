defmodule ApiWeb.NotificationChannelControllerTest do
  use ApiWeb.ConnCase
  import Api.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "listing" do
    test "all channels", %{conn: conn} do
      insert_pair(:notification_channel)

      conn = conn
             |> get(notification_channel_path(conn, :index))
             |> doc

      response = json_response(conn, 200)["data"]

      assert length(response) == 2
    end
  end
end
