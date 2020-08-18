defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(string) when is_binary(string) do
    string
    |> String.split()
    |> Enum.map(fn word -> word |> to_charlist() |> translate() |> to_string() end)
    |> Enum.join(" ")
  end

  def translate('qu' ++ rest), do: rest ++ 'quay'

  def translate([consonant, ?q, ?u | rest]) when consonant not in 'aeiou',
    do: rest ++ [consonant | 'quay']

  def translate([?y, consonant | _] = word) when consonant not in 'aeiou', do: word ++ 'ay'
  def translate([?x, consonant | _] = word) when consonant not in 'aeiou', do: word ++ 'ay'
  def translate(word) when hd(word) in 'aeiou', do: word ++ 'ay'

  def translate(word) do
    prefix = Enum.take_while(word, &(&1 not in 'aeiou'))
    Enum.drop(word, length(prefix)) ++ prefix ++ 'ay'
  end
end
