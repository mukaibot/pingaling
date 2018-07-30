defmodule ApiWeb.ManifestView do
  use ApiWeb, :view
  alias ApiWeb.EndpointView

  def render("apply.json", %{result: {:ok, resource}}) do
    EndpointView.render("endpoint.json", %{endpoint: resource})
  end

  def render("apply.json", %{result: {:created, resource}}) do
    EndpointView.render("endpoint.json", %{endpoint: resource})
  end

  def render("apply.json", %{result: {:bad_request, message}}) do
    message
  end
end
