defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    ~r/\p{Lu}|\b\p{Ll}/u
    |> Regex.scan(string)
    |> Enum.map(fn([x]) -> String.upcase(x) end)
    |> Enum.join()
  end
end
