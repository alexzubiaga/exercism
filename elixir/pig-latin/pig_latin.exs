defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&pigword/1)
    |> Enum.join(" ")
  end

  for vovel <- ["yt", "xr", "a", "e", "i", "o", "u"] do
    defp pigword(unquote(vovel) <> rest) do
      unquote(vovel) <> rest <> "ay"
    end
  end

  for consonantLike <- ["squ", "thr", "sch", "ch", "qu", "th", quote do <<var!(consonant)::bytes-size(1)>> end] do
    defp pigword(unquote(consonantLike) <> rest) do
      rest <> unquote(consonantLike) <> "ay"
    end
  end
end

