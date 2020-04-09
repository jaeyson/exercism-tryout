defmodule HelloWorldTest do
  use ExUnit.Case
  import ExercismElixir

  test "says 'Hello, World!'", do: assert hello() == "Hello, World!"
end
