defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    find_prime(2, [], count, true)
  end

  @doc """
  Recursive Erastotenes sieve
  """
  defp find_prime(2, _, 0, _), do: raise("weird case")
  defp find_prime(_, [found|_], 0, _), do: found
  defp find_prime(number, found, remaining, true), do: find_prime(number+1, [number|found], remaining-1, is_prime?(number+1, [number|found]))
  defp find_prime(number, found, remaining, false), do: find_prime(number+1, found, remaining, is_prime?(number+1, found))

  defp is_prime?(_, []), do: true
  defp is_prime?(number, [p | _]) when rem(number, p) == 0, do: false
  defp is_prime?(number, [_ | list]), do: is_prime?(number, list)

end
