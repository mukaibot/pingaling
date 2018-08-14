defmodule Api.CheckHandlers.SuccessHandlerTest do
  use Api.DataCase
  import Api.Factory
  alias Api.Repo
  alias Api.CheckHandlers.SuccessHandler
  alias Api.Resources.HealthStatus

  describe "success handler" do
    test "it creates a :healthy health status" do
      ep_fact = insert(:endpoint)

      SuccessHandler.handle(ep_fact)

      last_health_status = Repo.one(
        from hs in HealthStatus,
        where: hs.endpoint_id == ^ep_fact.id,
        order_by: [desc: :inserted_at],
        limit: 1
      )

      assert last_health_status.status == :healthy
    end
  end
end
