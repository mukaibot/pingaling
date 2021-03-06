defmodule ApiWeb.Manifests.ManifestControllerNotificationPolicyTest do
  use ApiWeb.ConnCase
  import Api.Factory
  import Ecto.Query, warn: false
  alias Api.Repo
  alias Api.NotificationChannels.NotificationPolicy

  @moduledoc false

  @name "foobar"
  @description "non-critical errors"
  @base %{"apiVersion" => 1, "kind" => "notifications/policy"}

  describe "applying a manifest" do
    test "creates a notification policy" do
      endpoint = insert(:endpoint)
      channel = insert(:notification_channel)
      create_params = Map.merge(
        @base,
        %{
          "spec" => %{
            "name" => @name,
            "endpoint" => endpoint.name,
            "channel" => channel.name
          }
        }
      )
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: create_params)
             |> doc

      assert json_response(conn, :created)["message"]
             |> String.contains?(@name)
    end

    test "updates a notification policy" do
      endpoint = insert(:endpoint)
      channel = insert(:notification_channel)
      create_params = Map.merge(
        @base,
        %{
          "spec" => %{
            "name" => @name,
            "endpoint" => endpoint.name,
            "channel" => channel.name
          }
        }
      )
      update_params = Map.merge(
        @base,
        %{
          "spec" => %{
            "name" => @name,
            "description" => @description,
            "endpoint" => endpoint.name,
            "channel" => channel.name
          }
        }
      )

      post(build_conn(), manifest_path(build_conn(), :apply), manifest: create_params)
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: update_params)
             |> doc

      last_policy = Repo.one(
        from np in NotificationPolicy,
        order_by: [
          desc: np.inserted_at
        ],
        limit: 1
      )
      assert json_response(conn, :ok)
      assert last_policy.description == @description
    end
  end

  describe "ways it can fail" do
    test "fails when endpoint doesn't exist" do
      bogus_endpoint_name = "tooth-fairy"
      channel = insert(:notification_channel)
      create_params = Map.merge(
        @base,
        %{
          "spec" => %{
            "name" => @name,
            "endpoint" => bogus_endpoint_name,
            "channel" => channel.name
          }
        }
      )
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: create_params)
      assert json_response(conn, :not_found)["message"]
             |> String.contains?(bogus_endpoint_name)
    end

    test "fails when notification channel doesn't exist" do
      bogus_channel_name = "miniature-pony"
      endpoint = insert(:endpoint)
      create_params = Map.merge(
        @base,
        %{
          "spec" => %{
            "name" => @name,
            "endpoint" => endpoint.name,
            "channel" => bogus_channel_name
          }
        }
      )
      conn = post(build_conn(), manifest_path(build_conn(), :apply), manifest: create_params)
      assert json_response(conn, :not_found)["message"]
             |> String.contains?(bogus_channel_name)
    end
  end
end
