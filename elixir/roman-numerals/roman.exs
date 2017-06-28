defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number), do: rec_numerals(number, [])
  
  defp rec_numerals(number, roman) when number >= 1000, do: rec_numerals(number-1000, ["M"| roman])
  defp rec_numerals(number, roman) when number >= 900, do: rec_numerals(number-900, ["CM"| roman])
  defp rec_numerals(number, roman) when number >= 500, do: rec_numerals(number-500, ["D"| roman])
  defp rec_numerals(number, roman) when number >= 400, do: rec_numerals(number-400, ["CD"| roman])
  defp rec_numerals(number, roman) when number >= 100, do: rec_numerals(number-100, ["C"| roman])
  defp rec_numerals(number, roman) when number >= 90, do: rec_numerals(number-90, ["XC"| roman])
  defp rec_numerals(number, roman) when number >= 50, do: rec_numerals(number-50, ["L"| roman])
  defp rec_numerals(number, roman) when number >= 40, do: rec_numerals(number-40, ["XL"| roman])
  defp rec_numerals(number, roman) when number >= 10, do: rec_numerals(number-10, ["X"| roman])
  defp rec_numerals(number, roman) when number >= 9, do: rec_numerals(number-9, ["IX"| roman])
  defp rec_numerals(number, roman) when number >= 5, do: rec_numerals(number-5, ["V"| roman])
  defp rec_numerals(number, roman) when number >= 4, do: rec_numerals(number-4, ["IV"| roman])
  defp rec_numerals(number, roman) when number >= 1, do: rec_numerals(number-1, ["I"| roman])
  defp rec_numerals(0, roman), do: roman |> Enum.reverse() |> Enum.join()

end
