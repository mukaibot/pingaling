defmodule ApiWeb.IncidentView do
  use ApiWeb, :view
  alias ApiWeb.IncidentView

  def render("index.json", %{incidents: incidents}) do
    %{data: render_many(incidents, IncidentView, "incident.json")}
  end

  def render("show.json", %{incident: incident}) do
    %{data: render_one(incident, IncidentView, "incident.json")}
  end

  def render("incident.json", %{incident: incident}) do
    %{
      id: incident.id,
      name: incident.endpoint.name,
      status: incident.status,
      url: incident.endpoint.url,
      updated_at: incident.updated_at,
      next_attempt: incident.endpoint.next_check
    }
  end
end
