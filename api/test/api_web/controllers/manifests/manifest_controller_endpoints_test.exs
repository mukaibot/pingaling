defmodule ApiWeb.Manifests.ManifestControllerEndpointsTest do
  use ApiWeb.ConnCase
  @moduledoc false

  @name "foobar-svc"
  @description "an excellent service"
  @base %{"apiVersion" => 1, "kind" => "checks/endpoint"}
  @create_attrs Map.merge(
                  @base,
                  %{
                    "spec" => %{
                      "url" => "https://google.com",
                      "name" => @name
                    }
                  }
                )
  @update_attrs Map.merge(
                  @base,
                  %{
                    "spec" => %{
                      "url" => "https://google.com",
                      "name" => @name,
                      "description" => @description
                    }
                  }
                )

  describe "applying a manifest" do
    test "creates an endpoint" do
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs)
             |> doc
      assert json_response(conn, :created)["name"] == @name
    end

    test "updates an endpoint" do
      create = post(build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs)
      assert json_response(create, :created)["description"] == nil

      update = post(build_conn(), manifest_path(build_conn(), :apply), manifest: @update_attrs)
               |> doc
      assert json_response(update, :ok)["description"] == @update_attrs
                                                          |> Map.get("spec")
                                                          |> Map.get("description")
    end
  end
end
