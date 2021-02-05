defmodule SecretHandshake do
  use Bitwise
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
  def commands(code) when code > 16, do: Enum.map(rem(code,16)..1, & gen(&1 &&& code)) |> Enum.filter(& &1!=nil) |> Enum.uniq
  def commands(code), do: Enum.map(1..rem(code,16), & gen(&1 &&& code)) |> Enum.filter(& &1!=nil) |> Enum.uniq
  def gen(1), do: "wink"
  def gen(2), do: "double blink"
  def gen(4), do: "close your eyes"
  def gen(8), do: "jump"
  def gen(_n), do: nil
end