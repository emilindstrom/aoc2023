defmodule Helpers do
  def translate_num(["", string]) do
    case Integer.parse(string) do
      {int, _} ->
        int

      _ ->
        case string do
          "one" -> 1
          "two" -> 2
          "three" -> 3
          "four" -> 4
          "five" -> 5
          "six" -> 6
          "seven" -> 7
          "eight" -> 8
          "nine" -> 9
        end
    end
  end
end

File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day1/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row ->
  list = Regex.scan(~r/(?=(one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9))/, row)

  String.to_integer(
    "#{List.first(list) |> Helpers.translate_num()}#{List.last(list) |> Helpers.translate_num()}"
  )
end)
|> Enum.sum()
|> IO.inspect()
