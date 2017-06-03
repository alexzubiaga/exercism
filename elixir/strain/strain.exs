defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean), filtered :: list(any)) :: list(any)
  def keep(list, fun, filtered \\ [])

  def keep([], _ , filtered), do: filtered

  def keep([item|list], fun, filtered) do
    if fun.(item) do
      keep(list, fun, filtered ++ [item])
    else
      keep(list, fun, filtered)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    keep(list, &(not fun.(&1)))
  end
end
