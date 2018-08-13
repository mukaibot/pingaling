defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
    resources "/endpoints", EndpointController, only: [:index]
    get "/health/summary", HealthSummaryController, :index
    get "/endpoints/:name", EndpointController, :show
    post "/manifest", ManifestController, :apply
  end
end
