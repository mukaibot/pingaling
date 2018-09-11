defmodule Api.CheckHandlers.EndpointTest do
  use Api.DataCase
  import Api.Factory
  alias Api.CheckHandlers.Endpoint
  alias Api.Resources.HealthSummariser

  setup do
    %{endpoint: insert(:endpoint)}
  end

  describe "handling results of an Endpoint check" do

    test "it considers a 200 to be success", context do
      Endpoint.handle_result({:ok, {{'HTTP/1.1', 200, 'OK'}, %{}, ""}}, context.endpoint)

      assert HealthSummariser.recent_health_statuses(context.endpoint, 1) == [:healthy]
    end

    test "it considers a 500 to be failure", context do
      Endpoint.handle_result({:error, {{'HTTP/1.1', 500, 'OK'}, %{}, ""}}, context.endpoint)

      assert HealthSummariser.recent_health_statuses(context.endpoint, 1) == [:unhealthy]
    end

    test "it considers a 404 to be failure", context do
      Endpoint.handle_result({:ok, {{'HTTP/1.1', 404, 'Not Found'}}}, context.endpoint)

      assert HealthSummariser.recent_health_statuses(context.endpoint, 1) == [:unhealthy]
    end
  end
end
