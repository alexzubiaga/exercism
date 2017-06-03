defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    last = String.length(s) - size
    if last < 0 or size <= 0 do
      []
    else
      for start <- 0..last, do:
        String.slice(s, start, size)
    end
  end
end

