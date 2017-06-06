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

  @vovels ["yt", "xr", "a", "e", "i", "o", "u"]
  for vovel <- @vovels do
    defp pigword((unquote(vovel) <> _) = word) do
      word <> "ay"
    end
  end

  for consonant <-
      ["squ", "thr", "sch", "ch", "qu", "th"]
      ++ (for letter <- 97..122, do: <<letter>>) -- @vovels do
    length = byte_size consonant
    defp pigword(<<consonant::binary-unquote(length), rest::binary>>) when consonant == <<unquote(consonant)>> do
      rest <> consonant <> "ay"
    end
  end
end

