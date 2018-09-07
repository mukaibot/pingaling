use Mix.Config

config :api, ApiWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "localhost", port: {:system, "PORT"}],
  server: true,
  version: Application.spec(:api, :vsn)

config :logger, level: :info

import_config "prod.secret.exs"
