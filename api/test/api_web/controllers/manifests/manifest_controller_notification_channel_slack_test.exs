defmodule ApiWeb.Manifests.ManifestControllerNotificationChannelSlackTest do
  use ApiWeb.ConnCase
  @moduledoc false

  @name "foobar"
  @description "non-critical errors"
  @base %{"apiVersion" => 1, "kind" => "notifications/slack"}
  @hook_url "https://hooks.slack.com/services/Z027TX47K/ABC1C7WUC/yT8EZZquxq4uEHkfE4gzrBoI"
  @create_attrs Map.merge(
                  @base,
                  %{
                    "spec" => %{
                      "webhook_url" => @hook_url,
                      "name" => @name
                    }
                  }
                )
  @update_attrs Map.merge(
                  @base,
                  %{
                    "spec" => %{
                      "webhook_url" => @hook_url,
                      "name" => @name,
                      "description" => @description
                    }
                  }
                )

  describe "applying a manifest" do
    test "creates a notification policy" do
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs)
             |> doc
      assert json_response(conn, :created)["message"]
             |> String.contains?(@name)
    end

    test "updates a notification policy" do
      post(build_conn(), manifest_path(build_conn(), :apply), manifest: @create_attrs)
      update = post(build_conn(), manifest_path(build_conn(), :apply), manifest: @update_attrs)
               |> doc
      assert json_response(update, :ok)["message"]
             |> String.contains?("Updated")
    end
  end
end
