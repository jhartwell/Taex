defmodule Taex.Mixfile do
  use Mix.Project

  def project do
    [app: :taex,
     version: "0.1.2",
     elixir: "~> 1.4",
     description: "Technical analysis library which can be used on stocks/forex/etc.",
     package: 
     [
       licenses: ["MIT"],
       maintainers: ["Jon Hartwell"],
       links: %{"GitHub" => "https://github.com/jhartwell/Taex"}
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:statistics, "~> 0.4.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
