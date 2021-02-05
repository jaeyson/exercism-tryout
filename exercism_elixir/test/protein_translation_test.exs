defmodule ProteinTranslationTest do
  use ExUnit.Case
  import ProteinTranslation

  test "AUG translates to methionine", do: assert of_codon("AUG") == {:ok, "Methionine"}

  test "identifies Phenylalanine codons" do
    assert of_codon("UUU") == {:ok, "Phenylalanine"}
    assert of_codon("UUC") == {:ok, "Phenylalanine"}
  end

  test "identifies Leucine codons" do
    assert of_codon("UUA") == {:ok, "Leucine"}
    assert of_codon("UUG") == {:ok, "Leucine"}
  end

  test "identifies Serine codons" do
    assert of_codon("UCU") == {:ok, "Serine"}
    assert of_codon("UCC") == {:ok, "Serine"}
    assert of_codon("UCA") == {:ok, "Serine"}
    assert of_codon("UCG") == {:ok, "Serine"}
  end

  test "identifies Tyrosine codons" do
    assert of_codon("UAU") == {:ok, "Tyrosine"}
    assert of_codon("UAC") == {:ok, "Tyrosine"}
  end

  test "identifies Cysteine codons" do
    assert of_codon("UGU") == {:ok, "Cysteine"}
    assert of_codon("UGC") == {:ok, "Cysteine"}
  end

  test "identifies Tryptophan codons" do
    assert of_codon("UGG") == {:ok, "Tryptophan"}
  end

  test "identifies stop codons" do
    assert of_codon("UAA") == {:ok, "STOP"}
    assert of_codon("UAG") == {:ok, "STOP"}
    assert of_codon("UGA") == {:ok, "STOP"}
  end

  test "translates rna strand into correct protein" do
    strand = "AUGUUUUGG"
    assert of_rna(strand) == {:ok, ~w(Methionine Phenylalanine Tryptophan)}
  end

  test "stops translation if stop codon present" do
    strand = "AUGUUUUAA"
    assert of_rna(strand) == {:ok, ~w(Methionine Phenylalanine)}
  end

  test "stops translation of longer strand" do
    strand = "UGGUGUUAUUAAUGGUUU"
    assert of_rna(strand) == {:ok, ~w(Tryptophan Cysteine Tyrosine)}
  end

  test "invalid RNA", do: assert of_rna("CARROT") == {:error, "invalid RNA"}
  test "invalid codon at end of RNA", do: assert of_rna("UUUROT") == {:error, "invalid RNA"}
  test "invalid codon", do: assert of_codon("INVALID") == {:error, "invalid codon"}
end
