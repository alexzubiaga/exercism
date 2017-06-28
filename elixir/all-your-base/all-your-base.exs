defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(digits, base_a, base_b) do
    digits
    |> tonumber(base_a, 0)
    |> fromnumber(base_b, [])
  end

  defp tonumber([], _, acc), do: acc
  defp tonumber([x|xs], base, acc), do: tonumber(xs, base, acc * base + x)

  defp fromnumber(0, _, list), do: list
  defp fromnumber(num, base, list), do: fromnumber(div(num, base), base, [rem(num, base)| list])
end
