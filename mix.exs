defmodule ElixirUmbrellaSampleApplication.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_umbrella_sample_application,
      version: "0.1.0",
      aliases: aliases(),
      apps_path: "apps",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger], mod: {ElixirUmbrellaSampleApplication.Application, []}]
  end

  defp deps do
    [
      {:distillery, "~> 2.1",
       warn_missing: false,
       git: "git@github.com:bitwalker/distillery.git",
       branch: "master",
       override: true},
      {:edeliver, "~> 1.8.0"}
    ]
  end

  defp aliases do
    [
      "core.reset": ["ecto.drop", "core.setup"],
      "core.seed": "run apps/core/priv/repo/seeds.exs",
      "core.setup": ["ecto.create", "ecto.migrate", "core.seed"]
    ]
  end
end
