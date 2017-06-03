defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number, noise \\ [])
  def convert(number, noise) when rem(number, 7) == 0, do: make_noise number, noise, 7, "Plong"
  def convert(number, noise) when rem(number, 5) == 0, do: make_noise number, noise, 5, "Plang"
  def convert(number, noise) when rem(number, 3) == 0, do: make_noise number, noise, 3, "Pling"
  def convert(number, []), do: to_string number
  def convert(_, noise), do: noise |> Enum.uniq() |> Enum.join()

  defp make_noise(number, noise, divisor, sound) do
    number
    |> div(divisor)
    |> convert([sound | noise])
  end
end
