defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    case {is_sublist(a, b), is_sublist(b, a)} do
      {false, false} -> :unequal
      {false, true} -> :superlist
      {true, false} -> :sublist
      {true, true} -> :equal
    end
  end

  defp is_sublist(a, b), do: is_sublist(a, b, {a, b})
  defp is_sublist([] , _, _), do: true
  defp is_sublist(_ , [], _), do: false
  defp is_sublist([x | xs] , [x | ys], store), do: is_sublist(xs, ys, store)
  defp is_sublist(_ , [y | ys], {a, [b | bs]}), do: is_sublist(a, bs, {a, bs})
end
