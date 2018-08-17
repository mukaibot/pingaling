Bureaucrat.start(
  writer: Bureaucrat.MarkdownWriter,
  default_path: "docs/api.md",
  paths: [],
  titles: [
    {ApiWeb.EndpointController, "API /api/endpoints"},
    {ApiWeb.HealthSummaryController, "API /api/health"},
    {ApiWeb.IncidentController, "API /api/incidents"},
    {ApiWeb.ManifestController, "API /api/manifest"},
  ],
  env_var: "DOC"
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)

