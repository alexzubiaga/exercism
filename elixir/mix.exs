defmodule Exercism do
    use Mix.Project

    def project do
        [app: :exercism,
        version: "0.1.0",
        elixir: "~> 1.4",
        start_permanent: Mix.env == :prod,
        deps: deps()]
    end

    def application do
        []
    end

    defp deps do
    [
        {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
        {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
        # {:wobserver, "~> 0.1"}
    ]
    end
end
