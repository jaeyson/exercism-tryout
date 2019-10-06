defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @lowcase ?a..?z
  @upcase ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(& gen(&1, shift))
    |> to_string
  end

  defp gen(n, shift) when n in @lowcase do
    n - ?a + shift |> rem(26) |> Kernel.+(?a)
  end
  defp gen(n, shift) when n in @upcase do
    n - ?A + shift |> rem(26) |> Kernel.+(?A)
  end
  defp gen(n, _shift), do: n

end
