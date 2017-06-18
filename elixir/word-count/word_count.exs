defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    ~r/[\p{N}-\p{L}ö]+/
    |> Regex.scan(sentence)
    |> Enum.map(fn([w]) -> String.downcase(w) end)
    |> Enum.group_by(&(&1))
    |> Map.new(fn({k, v}) -> {k, Enum.count(v)} end)
  end
end
