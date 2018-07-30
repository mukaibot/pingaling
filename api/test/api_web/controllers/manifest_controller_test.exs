defmodule ApiWeb.ManifestControllerTest do
  use ApiWeb.ConnCase
  @moduledoc false

  @name "foobar-svc"
  @description "an excellent service"
  @base %{ "apiVersion" => 1, "kind" => "checks/endpoint" }
  @create_attrs Map.merge(@base, %{ "spec" => %{ "url" => "https://google.com", "name" => @name } })
  @update_attrs Map.merge(@base, %{ "spec" => %{ "url" => "https://google.com", "name" => @name, "description" => @description } })

  describe "apply" do
    test "applying a manifest creates an endpoint" do
      conn = post build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs
      assert json_response(conn, :created)["name"] == @name
    end

    test "applying a manifest updates an endpoint" do
      create = post build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs
      assert json_response(create, :created)["description"] == nil

      update = post build_conn(), manifest_path(build_conn(), :apply), manifest: @update_attrs
      assert json_response(update, :ok)["description"] == @update_attrs
                                                          |> Map.get("spec")
                                                          |> Map.get("description")
    end

    test "manifest must be applied with an apiVersion" do
      without_api_version = post build_conn(), manifest_path(build_conn(), :apply), manifest: %{"kind" => "throbbler"}

      assert json_response(without_api_version, :bad_request) |> Map.get("message") |> String.contains?("apiVersion")
    end

    test "manifest must be applied with the correct apiVersion" do
      incorrect_api_version = post build_conn(), manifest_path(build_conn(), :apply), manifest: %{"apiVersion" => "throbbler"}

      assert json_response(incorrect_api_version, :bad_request) |> Map.get("message") |> String.contains?("apiVersion")
    end

    test "manifest must be applied with kind" do
      missing_kind = post build_conn(), manifest_path(build_conn(), :apply), manifest: %{"apiVersion" => 1}

      assert json_response(missing_kind, :bad_request) |> Map.get("message") |> String.contains?("Missing kind")
    end

    test "manifest must be applied with the correct kind" do
      missing_kind = post build_conn(), manifest_path(build_conn(), :apply), manifest: %{"apiVersion" => 1, "kind" => "throbbler"}

      assert json_response(missing_kind, :bad_request) |> Map.get("message") |> String.contains?("supported kind")
    end

    test "applying manifest without spec returns error" do
      without_spec = post build_conn(), manifest_path(build_conn(), :apply), manifest: @base

      assert json_response(without_spec, :bad_request) |> Map.get("message") |> String.contains?("Missing spec")
    end
  end
end
