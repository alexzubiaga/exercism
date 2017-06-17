defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(is_anagram(base))
  end

  defp is_anagram(base) do
    # avoid evaluating base multiple times
    low_base = String.downcase(base)
    norm_base = norm(base)

    &(low_base != String.downcase(&1) and norm_base == norm(&1))
  end

  defp norm(str) do
    str
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.sort
  end
end
