defmodule Api.Factory do
  use ExMachina.Ecto, repo: Api.Repo

  def endpoint_factory do
    %Api.Resources.Endpoint{
      name: sequence(:name, &"my-service#{&1}"),
      url: sequence(
        :url,
        ["https://service.svc.local/healthz", "http://foobar.com.au/diagnostic", "https://dingbats.svc.local/boop"]
      ),
      health_statuses: [build(:health_status)]
    }
  end

  def health_status_factory do
    %Api.Resources.HealthStatus{
      status: :pending,
      type: :endpoint
    }
  end

  def incident_factory do
    %Api.Resources.Incident{
      status: :open,
      endpoint: [build(:endpoint)]
    }
  end

  def notification_channel_factory do
    %Api.NotificationChannels.ChannelConfiguration{
      name: sequence(:name, &"channel#{&1}"),
      type: sequence(:type, [:slack, :pagerduty]),
      data: %{"foo" => "bar"}
    }
  end

  def notification_policy_factory do
    %Api.NotificationChannels.NotificationPolicy{
      name: sequence(:name, &"notification_policy#{&1}"),
      endpoint: insert(:endpoint),
      notification_channel: insert(:notification_channel)
    }
  end
end
