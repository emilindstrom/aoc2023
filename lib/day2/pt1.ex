# The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
max = %{"blue" => 14, "green" => 13, "red" => 12}

File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day2/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row -> String.split(row, [":", ";"]) end)
|> Enum.map(fn [game_id | rest] ->
  "Game " <> id = game_id

  sets =
    Enum.map(rest, fn item ->
      games = String.split(item, ",")

      Enum.map(games, fn game ->
        [amount, color] = String.split(game, " ", trim: true)
        {color, String.to_integer(amount)}
      end)
      |> Map.new()
    end)

  {String.to_integer(id), sets}
end)
|> Enum.filter(fn {_id, games} ->
  Enum.all?(games, fn game ->
    blue = game["blue"] || 0
    green = game["green"] || 0
    red = game["red"] || 0

    blue <= max["blue"] and
      green <= max["green"] and
      red <= max["red"]
  end)
end)
|> Enum.map(fn {id, _} -> id end)
|> Enum.sum()
|> IO.inspect()
