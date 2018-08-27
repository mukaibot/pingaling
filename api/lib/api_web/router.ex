defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
    delete "/endpoints/:name", EndpointController, :delete
    delete "/notification_channels/:name", NotificationChannelController, :delete
    delete "/notification_policies/:name", NotificationPolicyController, :delete
    get "/endpoints/:name", EndpointController, :show
    get "/health/summary", HealthSummaryController, :index
    get "/notification_channels", NotificationChannelController, :index
    get "/notification_policies", NotificationPolicyController, :index
    post "/manifest", ManifestController, :apply
    resources "/incidents", IncidentController, only: [:index]
  end
end
