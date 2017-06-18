defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&transcribe/1)
  end

  @external_resource readme = Path.join([__DIR__], "README.md")

  for [_, <<dna :: 8>>, <<rna :: 8>>] <-
    readme
    |> File.stream!([:utf8], :line)
    |> Stream.map(&Regex.run(~r/^\* `(.)` -> `(.)`$/, &1))
  do
    defp transcribe(unquote(dna)), do: unquote(rna)
  end
end
