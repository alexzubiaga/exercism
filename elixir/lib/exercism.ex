defmodule Exercism do
    @moduledoc """
    Automatically loads all exercise scripts.
    """
    for exercise <- Path.wildcard("*/*_test.exs") do
        @external_resource Path.expand(exercise)
        @external_resource Path.expand(String.replace(exercise, "_test.exs", ".exs"))
        file = Path.basename exercise
        directory = exercise |> Path.expand |> Path.dirname
        Code.require_file file, directory
    end
end
