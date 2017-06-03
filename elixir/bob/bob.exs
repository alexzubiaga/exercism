defmodule Bob do
  def hey(input) do
    cond do
        String.match?(input, ~r/\?$/) -> "Sure."
        String.match?(input, ~r/^\s*$/) -> "Fine. Be that way!"
        String.match?(input, ~r/^[\P{Ll}]*[\p{Lu}][\P{Ll}]*$/u)-> "Whoa, chill out!"
        true -> "Whatever."
    end
  end
end
