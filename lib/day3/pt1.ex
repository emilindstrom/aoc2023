data =
  File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day3/input.txt")
  |> String.split("\n", trim: true)
  |> Enum.with_index()
  |> Enum.map(fn {row, y} ->
    String.graphemes(row)
    |> Enum.with_index()
    |> Enum.map(fn {col, x} ->
      {x, y, col}
    end)
  end)

numbers =
  Enum.reduce(data, [], fn set, acc ->
    acc ++ Enum.chunk_by(set, fn {_x, _y, item} -> Integer.parse(item) == :error end)
  end)
  |> Enum.reject(fn set ->
    Enum.any?(set, fn {_x, _y, item} -> Integer.parse(item) == :error end)
  end)

characters =
  Enum.reduce(data, [], fn set, acc ->
    acc ++
      Enum.filter(set, fn {_x, _y, item} -> Integer.parse(item) == :error and item != "." end)
  end)

Enum.filter(numbers, fn set ->
  Enum.any?(set, fn {x, y, _item} ->
    neighbors = [
      {x, y - 1},
      {x, y + 1},
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]

    Enum.any?(neighbors, fn {x1, y1} ->
      Enum.find(characters, fn {x, y, _} -> y == y1 and x == x1 end)
    end)
  end)
end)
|> Enum.map(fn set ->
  Enum.map(set, fn {_, _, num} -> num end) |> Enum.join() |> String.to_integer()
end)
|> Enum.sum()
|> IO.inspect()
