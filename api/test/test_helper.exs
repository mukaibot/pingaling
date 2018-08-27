Bureaucrat.start(
  writer: Bureaucrat.MarkdownWriter,
  default_path: "docs/api.md",
  paths: [],
  titles: [
    {ApiWeb.EndpointController, "API /api/endpoints"},
    {ApiWeb.HealthSummaryController, "API /api/health"},
    {ApiWeb.IncidentController, "API /api/incidents"},
    {ApiWeb.Manifests.ManifestControllerEndpoints, "API /api/manifest"},
    {ApiWeb.Manifests.ManifestControllerNotificationChannelSlack, "API /api/manifest"},
    {ApiWeb.Manifests.ManifestControllerNotificationPolicy, "API /api/manifest"},
    {ApiWeb.NotificationChannelController, "API /api/notification_channels"},
    {ApiWeb.NotificationPolicyController, "API /api/notification_policies"},
  ],
  env_var: "DOC"
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)

