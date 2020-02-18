defmodule Math.Mixfile do
  use Mix.Project

  @source_url "https://github.com/folz/math"

  def project do
    [
      app: :math,
      version: "0.5.0",
      elixir: "~> 1.2",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: @source_url,
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: docs()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    The Math library extends Elixir with many common math-related functions, constants and (optionally) operators.
    """
  end

  defp package do
    [
      name: :math,
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["Rodney Folz", "Wiebe-Marten Wijnja/Qqwy"],
      licenses: ["Apache-2.0"],
      links: %{GitHub: @source_url}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.11.4", only: [:docs]},
      {:inch_ex, ">= 0.0.0", only: [:docs]},
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
