defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    <<
      reverse :: bits-size(1),
      jump    :: bits-size(1),
      eyes    :: bits-size(1),
      blink   :: bits-size(1),
      wink    :: bits-size(1)
    >> = <<code::integer-size(5)>>

    []
    |> doIf(jump, &(["jump"|&1]))
    |> doIf(eyes, &(["close your eyes"|&1]))
    |> doIf(blink, &(["double blink"|&1]))
    |> doIf(wink, &(["wink"|&1]))
    |> doIf(reverse, &Enum.reverse/1)
  end

  defp doIf(l, b, f) do
    if b == <<1::1>> , do: f.(l), else: l
  end
end

