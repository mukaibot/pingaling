defmodule ApiWeb.EndpointControllerTest do
  use ApiWeb.ConnCase
  alias Api.Resources

  @create_attrs %{
    description: "some description",
    name: "some-name",
    url: "http://my-service/healthz"
  }

  def fixture(:endpoint) do
    {:ok, date, 0} = DateTime.from_iso8601("2010-04-17T14:00:00.0Z")
    {:ok, endpoint} = Resources.create_endpoint(Map.merge(@create_attrs, %{next_check: date}))
    endpoint
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "getting an endpoint" do
    test "by name", %{conn: conn} do
      endpoint = create_endpoint("")
      {
        :ok,
        [
          endpoint: %{
            name: name
          }
        ]
      } = endpoint

      conn = conn
             |> get(endpoint_path(conn, :show, name))
             |> doc

      assert json_response(conn, 200)["data"] == %{
               "name" => "some-name",
               "description" => "some description",
               "next_check" => "2010-04-17T14:00:00.000000Z",
               "url" => "http://my-service/healthz"
             }
    end
  end

  describe "deleting an endpoint" do
    test "it deletes the endpoint", %{conn: conn} do
      endpoint = create_endpoint("")
      {
        :ok,
        [
          endpoint: %{
            name: name
          }
        ]
      } = endpoint

      conn = delete(conn, endpoint_path(conn, :delete, name))
             |> doc

      assert json_response(conn, 200) == %{"message" => "Deleted endpoint #{name}" }
    end
  end

  defp create_endpoint(_) do
    endpoint = fixture(:endpoint)
    {:ok, endpoint: endpoint}
  end
end
