defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes
    |> Stream.chunk_by(&(&1))
    |> Stream.map(fn
        [] -> ""
        [i] -> i
        [i|l] -> "#{Enum.count([i|l])}#{i}"
      end)
    |> Enum.join()
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/(\p{N}*)([\p{L} ])/u
    |> Regex.scan(string, [capture: :all_but_first])
    |> Stream.flat_map(fn
        ["", i] -> [i]
        [c, i] -> {count, _} = Integer.parse(c)
                  for _ <- 1..count, do: i
      end)
    |> Enum.join()
  end
end
