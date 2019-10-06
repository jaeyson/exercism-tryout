defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count('', _nucleotide), do: 0
  def count(strand, nucleotide) do
    # Enum.filter(strand, &(&1 == ?A)) |> Enum.count
    Enum.count(strand, &(&1 == nucleotide))
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(''), do: %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
  def histogram(strand) do
    %{?A => Enum.count(strand, & &1 == ?A),
      ?T => Enum.count(strand, & &1 == ?T),
      ?C => Enum.count(strand, & &1 == ?C),
      ?G => Enum.count(strand, & &1 == ?G)}
  end
end
