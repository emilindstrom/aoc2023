File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day1/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row ->
  list = String.replace(row, ~r/[^\d]/, "") |> String.split("", trim: true)
  String.to_integer("#{List.first(list)}#{List.last(list)}")
end)
|> Enum.sum()
|> IO.inspect()
