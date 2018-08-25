defmodule FailingTest do
  use ApiWeb.ConnCase

  describe "failing on purpose" do
    test "fails to test CI" do
      assert "foo" == "bar"
    end
  end
end
