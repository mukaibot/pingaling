defmodule ApiWeb.ManifestControllerTest do
  use ApiWeb.ConnCase
  @moduledoc false

  @name "foobar-svc"
  @description "an excellent service"
  @create_attrs %{ apiVersion: 1, kind: "checks/endpoint", spec: %{ url: "https://google.com", name: @name } }
  @update_attrs %{ apiVersion: 1, kind: "checks/endpoint", spec: %{ url: "https://google.com", name: @name, description: @description } }

  describe "apply" do
    test "applying a manifest creates an endpoint" do
      conn = post build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs
      assert json_response(conn, :created)["name"] == @name
    end

    test "applying a manifest updates an endpoint" do
      create = post build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs
      assert json_response(create, :created)["description"] == nil

      update = post build_conn(), manifest_path(build_conn(), :apply), manifest: @update_attrs
      assert json_response(update, :ok)["description"] == @update_attrs.spec.description
    end
  end
end
