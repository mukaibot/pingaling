defmodule Api.IncidentManagement.IncidentCreatorTest do
  use Api.DataCase
  import Api.Factory
  alias Api.IncidentManagement.IncidentCreator
  alias Api.Resources.Incident

  describe "endpoints" do
    test "creates incident for unhealthy service" do
      ep = insert(:endpoint)
      insert(:health_status, %{endpoint: ep, status: :unhealthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})
      insert(:health_status, %{endpoint: ep, status: :unhealthy})

      IncidentCreator.create_incidents()

      assert Repo.one(from i in Incident, select: count(i.id)) == 1
    end
  end
end
