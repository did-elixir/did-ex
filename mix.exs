defmodule DID.MixProject do
  use Mix.Project

  def project do
    [
      app: :did,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # TODO: change to release versions
      {:rdf, github: ~c"rdf-elixir/rdf-ex", override: true},
      {:grax, github: ~c"rdf-elixir/grax"},
      {:json_ld, "~> 0.3"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
