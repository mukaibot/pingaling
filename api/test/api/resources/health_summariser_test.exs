defmodule Api.Resources.HealthSummariserTest do
  use Api.DataCase
  import Api.Factory
  alias Api.Resources.HealthSummariser

  describe "endpoints" do
    test "returns only the latest health status" do
      ep = insert(:endpoint)
      insert_pair(:health_status, endpoint: ep)

      assert length(HealthSummariser.find()) == 1
    end

    test "returns multiple statuses to form a summary" do
      insert_pair(:endpoint)

      assert length(HealthSummariser.find()) == 2
    end
  end
end
