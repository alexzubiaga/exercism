defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Stream.filter(
      fn n ->
        factors |> Enum.any?(fn f -> rem(n, f) == 0 end)
      end)
    |> Enum.sum()
  end
end
