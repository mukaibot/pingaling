defmodule Api.CheckHandlers.SuccessHandlerTest do
  use Api.DataCase
  import Api.Factory
  alias Api.CheckHandlers.SuccessHandler
  alias Api.Resources.HealthSummariser

  describe "success handler" do
    test "it creates a :healthy health status" do
      ep_fact = insert(:endpoint)

      SuccessHandler.handle(ep_fact)

      assert HealthSummariser.recent_health_statuses(ep_fact, 1) == [:healthy]
    end
  end
end
