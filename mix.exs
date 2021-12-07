defmodule Math.Mixfile do
  use Mix.Project

  @source_url "https://github.com/folz/math"
  @version "0.7.0"

  def project do
    [
      app: :math,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [docs: :docs],
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      name: :math,
      description: "The Math library extends Elixir with many common math-related "
        <> "functions, constants and (optionally) operators.",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Rodney Folz", "Wiebe-Marten Wijnja/Qqwy"],
      licenses: ["Apache-2.0"],
      links: %{GitHub: @source_url}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:docs], runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "master",
      formatters: ["html"]
    ]
  end
end
