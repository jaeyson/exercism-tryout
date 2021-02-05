defmodule SecretHandshakeTest do
  use ExUnit.Case
  import SecretHandshake

  # Create a handshake for a number
  test "wink for 1", do: assert commands(1) == ["wink"]
  test "double blink for 10", do: assert commands(2) == ["double blink"]
  test "close your eyes for 100", do: assert commands(4) == ["close your eyes"]
  test "5", do: assert commands(5) == ["wink", "close your eyes"]
  test "jump for 1000", do: assert commands(8) == ["jump"]
  test "combine two actions", do: assert commands(3) == ["wink", "double blink"]
  test "reverse two actions", do: assert commands(19) == ["double blink", "wink"]
  test "reversing one action gives the same action", do: assert commands(24) == ["jump"]
  test "reversing no actions still gives no actions", do: assert commands(16) == []
  test "all possible actions", do: assert commands(15) == ["wink", "double blink", "close your eyes", "jump"]
  test "reverse all possible actions", do: assert commands(31) == ["jump", "close your eyes", "double blink", "wink"]
  test "do nothing for zero", do: assert commands(0) == []
  test "do nothing if lower 5 bits not set", do: assert commands(32) == []
end
