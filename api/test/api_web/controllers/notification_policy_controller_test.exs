defmodule ApiWeb.NotificationPolicyControllerTest do
  use ApiWeb.ConnCase
  import Api.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "listing" do
    test "all policies", %{conn: conn} do
      insert_pair(:notification_policy)

      conn = conn
             |> get(notification_policy_path(conn, :index))
             |> doc

      response = json_response(conn, 200)["data"]

      assert length(response) == 2
    end
  end

  describe "deleting" do
    test "policy is deleted", %{conn: conn} do
      policy = insert(:notification_policy)

      conn = delete(conn, notification_policy_path(conn, :delete, policy.name))
             |> doc

      assert json_response(conn, 200) == %{"message" => "Deleted notification policy #{policy.name}"}
    end
  end
end
