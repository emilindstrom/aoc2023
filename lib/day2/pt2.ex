File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day2/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row -> String.split(row, [":", ";"]) end)
|> Enum.map(fn [_game_id | rest] ->
  sets =
    Enum.map(rest, fn item ->
      games = String.split(item, ",")

      Enum.map(games, fn game ->
        [amount, color] = String.split(game, " ", trim: true)
        {color, String.to_integer(amount)}
      end)
    end)
    |> List.flatten()

  {_, blue} =
    Enum.filter(sets, fn {color, _num} -> color == "blue" end)
    |> Enum.max_by(fn {_color, num} -> num end)

  {_, green} =
    Enum.filter(sets, fn {color, _num} -> color == "green" end)
    |> Enum.max_by(fn {_color, num} -> num end)

  {_, red} =
    Enum.filter(sets, fn {color, _num} -> color == "red" end)
    |> Enum.max_by(fn {_color, num} -> num end)

  blue * green * red
end)
|> Enum.sum()
|> IO.inspect()
