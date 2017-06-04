defmodule ProteinTranslation do
  @codonToProtein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna
    |> String.graphemes
    |> Stream.chunk(3)
    |> Stream.map(&to_string/1)
    |> Stream.map(&of_codon/1)
    |> Enum.reduce_while({:ok, []}, &sequencer/2)
    |> (fn
        {:ok, l} -> {:ok, Enum.reverse l}
        x -> x
      end).()
  end

  @spec sequencer({atom, String.t()}, {atom, list(String.t())}) :: {atom, {atom, list(String.t())}}
  defp sequencer({:ok, "STOP"}, result), do: {:halt, result}
  defp sequencer({:error, _}, _), do: {:halt, {:error, "invalid RNA"}}
  defp sequencer({:ok, codon}, {_, strain}), do: {:cont, {:ok, [codon | strain]}}
  

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    protein = Map.fetch(@codonToProtein, codon)
    case protein do
       :error -> {:error, "invalid codon"}
       p -> p
    end
  end
end

