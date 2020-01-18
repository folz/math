defmodule Math.Mixfile do
  use Mix.Project

  def project do
    [app: :math,
     version: "0.3.1",
     elixir: "~> 1.2",
     description: description(),
     package: package(),
     deps: deps(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    The Math library extends Elixir with many common math-related functions, constants and (optionally) operators.
    """
  end

  defp package do
    [
      maintainers: ["Rodney Folz", "Wiebe-Marten Wijnja/Qqwy"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub": "https://github.com/folz/math"}
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.11.4", only: [:dev]}
    ]
  end
end
