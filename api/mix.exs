defmodule Api.Mixfile do
  use Mix.Project

  def project do
    [
      app: :api,
      version: version(),
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Api.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # This assumes version.txt is in the API dir. The Dockerfile copies this in from
  # the root of the git repo when docker-compose is run
  def version do
    Path.join([__ENV__.file, "..", "version.txt"])
    |> Path.expand
    |> File.read!
    |> String.trim
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bureaucrat, "~> 0.2.4"},
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 2.0"},
      {:ecto_enum, "~> 1.0"},
      {:ex_machina, "~> 2.2"},
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 1.2"},
      {:phoenix, "~> 1.3.3"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
