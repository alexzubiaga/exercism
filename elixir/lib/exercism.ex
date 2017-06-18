defmodule Exercism do
    @doc """
    Automatically loads all exercise scripts.
    """
    for exercise <- Path.wildcard("*/*_test.exs") do
        file = Path.basename exercise
        directory = exercise |> Path.expand |> Path.dirname
        Code.require_file file, directory
    end
end
