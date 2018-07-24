use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :api, ApiWeb.Endpoint,
  secret_key_base: "GI34d05FmNvu3JsMQWdOELrWjQP+4xOvYt6CGJ2CvSPx15kGuP+RtzRIQfYCtDw1"

# Configure your database
config :api, Api.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pingaling",
  pool_size: 15
