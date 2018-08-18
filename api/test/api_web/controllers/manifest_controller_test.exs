defmodule ApiWeb.ManifestControllerTest do
  use ApiWeb.ConnCase
  @moduledoc false

  @base %{"apiVersion" => 1, "kind" => "checks/endpoint"}

  describe "applying a manifest" do
    test "manifest must be applied with an apiVersion" do
      without_api_version = post build_conn(),
                                 manifest_path(build_conn(), :apply),
                                 manifest: %{
                                   "kind" => "throbbler"
                                 }

      assert json_response(without_api_version, :bad_request)
             |> Map.get("message")
             |> String.contains?("apiVersion")
    end

    test "manifest must be applied with the correct apiVersion" do
      incorrect_api_version = post build_conn(),
                                   manifest_path(build_conn(), :apply),
                                   manifest: %{
                                     "apiVersion" => "throbbler"
                                   }

      assert json_response(incorrect_api_version, :bad_request)
             |> Map.get("message")
             |> String.contains?("apiVersion")
    end

    test "manifest must be applied with kind" do
      missing_kind = post build_conn(),
                          manifest_path(build_conn(), :apply),
                          manifest: %{
                            "apiVersion" => 1
                          }

      assert json_response(missing_kind, :bad_request)
             |> Map.get("message")
             |> String.contains?("Missing kind")
    end

    test "manifest must be applied with the correct kind" do
      missing_kind = post build_conn(),
                          manifest_path(build_conn(), :apply),
                          manifest: %{
                            "apiVersion" => 1,
                            "kind" => "throbbler"
                          }

      assert json_response(missing_kind, :bad_request)
             |> Map.get("message")
             |> String.contains?("supported kind")
    end

    test "applying manifest without spec returns error" do
      without_spec = post build_conn(), manifest_path(build_conn(), :apply), manifest: @base

      assert json_response(without_spec, :bad_request)
             |> Map.get("message")
             |> String.contains?("Missing spec")
    end
  end
end
