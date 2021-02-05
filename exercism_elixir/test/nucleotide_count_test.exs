defmodule NucleotideCountTest do
  use ExUnit.Case
  import NucleotideCount

  test "empty dna string has no adenine", do: assert count('', ?A) == 0
  test "repetitive cytosine gets counted", do: assert count('CCCCC', ?C) == 5
  test "counts only thymine", do: assert count('GGGGGTAACCCGG', ?T) == 1

  test "empty dna string has no nucleotides" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    assert histogram('') == expected
  end

  test "repetitive sequence has only guanine" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
    assert histogram('GGGGGGGG') == expected
  end

  test "counts all nucleotides" do
    s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
    assert histogram(s) == expected
  end
end
