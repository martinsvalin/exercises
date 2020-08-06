defmodule Say do
  @max 1_000_000_000_000

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(n) when n in 0..(@max - 1), do: {:ok, say(n)}
  def in_english(_), do: {:error, "number is out of range"}

  defp say(0), do: "zero"
  defp say(1), do: "one"
  defp say(2), do: "two"
  defp say(3), do: "three"
  defp say(4), do: "four"
  defp say(5), do: "five"
  defp say(6), do: "six"
  defp say(7), do: "seven"
  defp say(8), do: "eight"
  defp say(9), do: "nine"
  defp say(10), do: "ten"
  defp say(11), do: "eleven"
  defp say(12), do: "twelve"
  defp say(13), do: "thirteen"
  defp say(14), do: "fourteen"
  defp say(15), do: "fifteen"
  defp say(16), do: "sixteen"
  defp say(17), do: "seventeen"
  defp say(18), do: "eighteen"
  defp say(19), do: "nineteen"
  defp say(20), do: "twenty"
  defp say(30), do: "thirty"
  defp say(40), do: "forty"
  defp say(50), do: "fifty"
  defp say(60), do: "sixty"
  defp say(70), do: "seventy"
  defp say(80), do: "eighty"
  defp say(90), do: "ninety"

  defp say(n) when n < 100 do
    say(n - rem(n, 10)) <> "-" <> say(rem(n, 10))
  end

  @hundred 100
  @thousand 1000
  @million 1_000_000
  @billion 1_000_000_000
  defp say(n) when n < @thousand, do: big(n, @hundred, " hundred")
  defp say(n) when n < @million, do: big(n, @thousand, " thousand")
  defp say(n) when n < @billion, do: big(n, @million, " million")
  defp say(n) when n < @max, do: big(n, @billion, " billion")

  defp big(n, unit, string) do
    case rem(n, unit) do
      0 -> say(div(n, unit)) <> string
      small -> say(n - small) <> " " <> say(small)
    end
  end
end
