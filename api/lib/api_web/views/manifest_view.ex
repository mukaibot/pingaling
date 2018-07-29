defmodule ApiWeb.ManifestView do
  use ApiWeb, :view
  alias ApiWeb.EndpointView

  def render("apply.json", %{status: :ok, resource: resource}) do
    EndpointView.render("endpoint.json", %{endpoint: resource})
  end

  def render("apply.json", %{status: :created, resource: resource}) do
    EndpointView.render("endpoint.json", %{endpoint: resource})
  end

  def render("apply.json", %{status: :failure}) do
    %{result: "Something went wrong"}
  end
end
