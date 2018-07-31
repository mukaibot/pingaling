defmodule Api.NextChecksTest do
  use Api.DataCase
  import Api.Factory
  alias Api.Resources.NextChecks

  describe "endpoints" do
    test "it fetches endpoints with a null next_check" do
      ep = insert(:endpoint)

      assert NextChecks.find() == [ep.name]
    end

    test "it fetches endpoints with an overdue next check" do
      {:ok, date, 0} = DateTime.from_iso8601("2010-04-17 14:00:00.000000Z")
      ep = insert(:endpoint, %{next_check: date})

      assert NextChecks.find() == [ep.name]
    end

    test "it does not include endpoints in the future" do
      {:ok, date, 0} = DateTime.from_iso8601("3010-04-17 14:00:00.000000Z")
      insert(:endpoint, %{next_check: date})

      assert NextChecks.find() == []
    end
  end
end
