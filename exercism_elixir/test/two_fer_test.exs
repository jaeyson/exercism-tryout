defmodule TwoFerTest do
  use ExUnit.Case
  import ExercismElixir

  test "no name given", do: assert two_fer() == "One for you, one for me"
  test "a name given", do: assert two_fer("Gilberto Barros") == "One for Gilberto Barros, one for me"

  test "when the parameter is a number" do
    assert_raise FunctionClauseError, fn -> two_fer(10) end
  end

  test "when the parameter is an atom" do
    assert_raise FunctionClauseError, fn -> two_fer(:bob) end
  end

  test "when the parameter is a charlist" do
    assert_raise FunctionClauseError, fn -> refute two_fer('Jon Snow') end
  end
end
