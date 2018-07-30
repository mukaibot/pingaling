defmodule Api.Factory do
  use ExMachina.Ecto, repo: Api.Repo

  def endpoint_factory do
    %Api.Resources.Endpoint{
      name: sequence(:name, &"my-service#{&1}"),
      url: sequence(:url, ["https://service.svc.local/healthz", "http://foobar.com.au/diagnostic", "https://dingbats.svc.local/boop"])
    }
  end
end
