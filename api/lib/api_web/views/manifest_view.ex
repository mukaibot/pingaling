defmodule ApiWeb.ManifestView do
  use ApiWeb, :view

  def render("apply.json", %{result: result}) do
    result
  end
end
