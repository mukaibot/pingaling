defmodule Api.Factory do
  use ExMachina.Ecto, repo: Api.Repo

  def endpoint_factory do
    %Api.Resources.Endpoint{
      name: sequence(:name, &"my-service#{&1}"),
      url: sequence(:url, ["https://service.svc.local/healthz", "http://foobar.com.au/diagnostic", "https://dingbats.svc.local/boop"]),
      health_statuses: [build(:health_status)]
    }
  end

  def health_status_factory do
    %Api.Resources.HealthStatus{
      status: :pending,
      type: :endpoint
    }
  end
end
