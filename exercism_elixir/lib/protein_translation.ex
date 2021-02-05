defmodule ProteinTranslation do
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna), do: rna |> check("RNA")

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon), do: codon |> check("codon")

  def check(strand, type) do
    strand
    |> split_by_3()
    |> Enum.all?(& &1 in all_values())
    |> extract(type, strand)
  end

  def extract(true, _type, strand) do
    strand
    |> split_by_3()
    |> Enum.map(&find_codon/1)
    |> output_tuple()
  end
  def extract(false, type, _strand), do: {:error, "invalid #{ type }"}

  def output_tuple(proteins) do
    proteins
    |> discard_elem()
    |> check_multiple_list()
    |> List.insert_at(0, :ok)
    |> List.to_tuple()
  end

  def check_multiple_list(list) when (length list) > 1, do: [ list ]
  def check_multiple_list(list) when (length list) == 1, do: list

  def discard_elem(proteins) when (length proteins) > 1 do
    index = proteins |> Enum.find_index(& &1 == "STOP")
    proteins |> Enum.slice(0, index || length proteins)
  end
  def discard_elem(proteins), do: proteins

  def find_codon(codon) do
    sample_data()
    |> Enum.find( fn {_protein, codons} -> codon in codons end )
    |> elem(0)
  end

  def all_values(), do: sample_data() |> Map.values() |> List.flatten()

  def split_by_3(codons) do
    for <<codon :: binary - 3 <- codons>>, do: codon
  end

  def sample_data() do
    # %{ protein => list of codons }
    %{
      "Cysteine"      => [ "UGU", "UGC" ],
      "Leucine"       => [ "UUA", "UUG" ],
      "Methionine"    => [ "AUG" ],
      "Phenylalanine" => [ "UUU", "UUC" ],
      "Serine"        => [ "UCU", "UCC", "UCA", "UCG" ],
      "Tryptophan"    => [ "UGG" ],
      "Tyrosine"      => [ "UAU", "UAC" ],
      "STOP"          => [ "UAA", "UAG", "UGA" ],
    }
  end
end