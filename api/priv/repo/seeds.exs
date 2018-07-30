# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
Api.Repo.insert!(%Api.Resources.Endpoint{
  name: "my-service",
  url: "http://my-service/healthz"
})
Api.Repo.insert!(%Api.Resources.Endpoint{
  name: "widget-service",
  url: "http://widget-service/heartbeat"
})
Api.Repo.insert!(%Api.Resources.Endpoint{
  name: "dingbat-throbbler",
  url: "http://dingbat-throbbler/diagnostic/status/heartbeat"
})
