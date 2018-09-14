# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
alias Api.Resources
alias Api.Repo

Repo.transaction fn ->
  Repo.insert!(
    %Api.Resources.Endpoint{
      name: "dingbat-poker",
      url: "http://my-service/healthz"
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :pending,
      endpoint: Resources.get_endpoint!("dingbat-poker")
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :unhealthy,
      endpoint: Resources.get_endpoint!("dingbat-poker")
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :unhealthy,
      endpoint: Resources.get_endpoint!("dingbat-poker")
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :healthy,
      endpoint: Resources.get_endpoint!("dingbat-poker")
    }
  )
  Repo.insert!(
    %Api.Resources.Incident{
      status: :auto_resolved,
      endpoint: Resources.get_endpoint!("dingbat-poker")
    }
  )
end

Repo.transaction fn ->
  Repo.insert!(
    %Api.Resources.Endpoint{
      name: "widget-aligner",
      url: "https://google.com.au"
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :pending,
      endpoint: Resources.get_endpoint!("widget-aligner")
    }
  )
end

Repo.transaction fn ->
  Repo.insert!(
    %Api.Resources.Endpoint{
      name: "foobar-throbbler",
      url: "http://google.com.au"
    }
  )
  Repo.insert!(
    %Api.Resources.HealthStatus{
      status: :pending,
      endpoint: Resources.get_endpoint!("foobar-throbbler")
    }
  )
end

Repo.transaction fn ->
  Repo.insert!(
    %Api.NotificationChannels.ChannelConfiguration {
      name: "slacktastic",
      type: "slack",
      data: %{ "webhook_url" => "https://hooks.slack.com/services/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"},
    }
  )
end