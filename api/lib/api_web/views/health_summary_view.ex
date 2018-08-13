defmodule ApiWeb.HealthSummaryView do
  use ApiWeb, :view
  alias ApiWeb.HealthSummaryView

  def render("index.json", %{health_summaries: health_summaries}) do
    %{data: render_many(health_summaries, HealthSummaryView, "health_summary.json")}
  end

  def render("show.json", %{health_summary: health_summary}) do
    %{data: render_one(health_summary, HealthSummaryView, "health_summary.json")}
  end

  def render("health_summary.json", %{health_summary: health_summary}) do
    %{
      name: health_summary.name,
      status: health_summary.status,
      type: health_summary.type,
      updated: health_summary.updated_at
    }
  end
end
