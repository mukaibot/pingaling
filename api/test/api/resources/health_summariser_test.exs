defmodule Api.Resources.HealthSummariserTest do
  use Api.DataCase
  import Api.Factory
  alias Api.Resources.HealthSummariser

  describe "individual endpoint" do
    test "returns only the latest health status" do
      ep = insert(:endpoint)
      insert_pair(:health_status, endpoint: ep)

      assert length(HealthSummariser.find()) == 1
    end

    test "returns multiple statuses to form a summary" do
      insert_pair(:endpoint)

      assert length(HealthSummariser.find()) == 2
    end

    test "returns the recent statuses for a single endpoint" do
      ep = insert(:endpoint)
      insert(:health_status, %{endpoint: ep, status: :healthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})

      recent = HealthSummariser.recent_health_statuses(ep, 3)

      assert [:pending, :healthy, :unhealthy] == recent
    end

    test "returns the unique statuses for a single endpoint in order" do
      ep = insert(:endpoint)
#      insert(:health_status, %{endpoint: ep, status: :healthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})
      insert(:health_status, %{endpoint: ep, status: :healthy})

      recent = HealthSummariser.recent_health_statuses(ep, 2)

      assert [:unhealthy, :healthy] == recent
    end
  end

  describe "multiple endpoints" do
    test "it finds all the unhealthy ones" do
      healthy_ep = insert(:endpoint)
      insert(:health_status, %{endpoint: healthy_ep, status: :healthy})
      unhealthy_ep = insert(:endpoint)
      insert(:health_status, %{endpoint: unhealthy_ep, status: :unhealthy})
      insert(:health_status, %{endpoint: unhealthy_ep, status: :unhealthy})
      insert(:health_status, %{endpoint: unhealthy_ep, status: :unhealthy})
      insert(:health_status, %{endpoint: unhealthy_ep, status: :unhealthy})

      [first | _] = HealthSummariser.unhealthy_endpoints()

      assert first.name == unhealthy_ep.name
    end
  end
end
