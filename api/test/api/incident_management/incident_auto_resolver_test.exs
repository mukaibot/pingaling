defmodule Api.IncidentManagement.IncidentAutoResolverTest do
  use Api.DataCase
  import Api.Factory
  alias Api.IncidentManagement.IncidentAutoResolver
  alias Api.Resources.Incident
  alias Api.Resources.HealthSummariser

  describe "endpoints" do
    test "resolves incidents when health returns" do
      ep = insert(:endpoint)
      insert(:incident, %{status: :open, endpoint: ep})
      insert(:health_status, %{endpoint: ep, status: :healthy})
      [last_health | _] = HealthSummariser.recent_health_statuses(ep, 1)

      assert last_health == :healthy
      assert Repo.one(from i in Incident, select: count(i.id), where: i.status == "open") == 1
      IncidentAutoResolver.resolve_incidents()
      assert Repo.one(from i in Incident, select: count(i.id), where: i.status == "open") == 0
    end
  end
end
