defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    is_balanced(str, [])
  end

  defp is_balanced("", []), do: true
  defp is_balanced("", _), do: false

  for {atom, [open, close]} <-
    [bracket: '[]', brace: '{}', parenthesis: '()'] do
    defp is_balanced(<<unquote(open)>> <> xs, stack), do: is_balanced(xs, [unquote(atom) | stack])
    defp is_balanced(<<unquote(close)>> <> xs, [unquote(atom) | stack]), do: is_balanced(xs, stack)
    defp is_balanced(<<unquote(close)>> <> _, _), do: false
  end

  defp is_balanced(<<_>> <> xs, stack), do: is_balanced(xs, stack)
end
