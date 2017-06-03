defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.graphemes 
    |> Enum.map(fn c -> rot(c, shift) end)
    |> Enum.join
  end

  defp rot(<<0b01::2, caps::1, char::5>>, shift) when char != 0b00000 and char <= 0b11010 do
    <<0b01::2, caps::1, rem(char-1+shift, 26)+1::5>>
  end

  defp rot(char, _), do: char
end

