defmodule HelloWorldTest do
  use ExUnit.Case
  import HelloWorld

  test "says 'Hello, World!'", do: assert hello() == "Hello, World!"
end
