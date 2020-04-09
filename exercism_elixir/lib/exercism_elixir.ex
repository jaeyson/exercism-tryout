defmodule ExercismElixir do
  use Bitwise

  @nucleotides [?A, ?C, ?G, ?T]

  @spec hello :: String.t()
  def hello, do: "Hello, World!"

  @spec secret_handshake(code :: integer) :: list(String.t())
  def secret_handshake(code) when code > 16, do: Enum.map(rem(code,16)..0, & gen(&1 &&& code)) |> Enum.filter(& &1!=nil)
  def secret_handshake(code), do: Enum.map(0..rem(code,16), & gen(&1 &&& code)) |> Enum.filter(& &1!=nil)
  def gen(1), do: "wink"
  def gen(2), do: "double blink"
  def gen(4), do: "close your eyes"
  def gen(8), do: "jump"
  def gen(_n), do: nil

  @spec count([char], char) :: non_neg_integer
  def count('', _nucleotide), do: 0
  def count(strand, nucleotide) do
    # Enum.filter(strand, &(&1 == ?A)) |> Enum.count
    Enum.count(strand, &(&1 == nucleotide))
  end

  @spec histogram([char]) :: map
  def histogram(''), do: %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
  def histogram(strand) do
    %{?A => Enum.count(strand, & &1 == ?A),
      ?T => Enum.count(strand, & &1 == ?T),
      ?C => Enum.count(strand, & &1 == ?C),
      ?G => Enum.count(strand, & &1 == ?G)}
  end

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

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(& gen(&1, shift))
    |> to_string
  end

  defp gen(n, shift) when n in ?a..?z do
    n - ?a + shift |> rem(26) |> Kernel.+(?a)
  end
  defp gen(n, shift) when n in ?A..?Z do
    n - ?A + shift |> rem(26) |> Kernel.+(?A)
  end
  defp gen(n, _shift), do: n

  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") when is_binary(name), do: "One for #{ name }, one for me"
end
