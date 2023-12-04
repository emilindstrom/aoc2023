File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day4/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row ->
  [_, winning, numbers] = String.split(row, [":", "|"])
  my_numbers = String.split(numbers, " ", trim: true)

  String.split(winning, " ", trim: true)
  |> Enum.reduce({1, 0}, fn num, {inc, acc} ->
    if num in my_numbers do
      {inc * 2, inc}
    else
      {inc, acc}
    end
  end)
end)
|> Enum.map(fn {_, num} -> num end)
|> Enum.sum()
|> IO.inspect()
