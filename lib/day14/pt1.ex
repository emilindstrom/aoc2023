defmodule Aoc2023.Day14.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day14/input.txt")
        |> String.split("\n")
        |> Enum.map(&String.graphemes/1)

  def run do
    map =
      Enum.with_index(@data)
      |> Enum.reduce(%{}, fn {row, y}, acc ->
        Map.merge(
          acc,
          Enum.reduce(Enum.with_index(row), %{}, fn {item, x}, acc ->
            Map.merge(acc, %{{x, y} => item})
          end)
        )
      end)

    {{_, max_y}, _} = Enum.max_by(map, fn {{_, y}, _} -> y end)

    Enum.with_index(@data)
    |> Enum.reduce(map, fn {row, y}, acc ->
      Enum.reduce(Enum.with_index(row), acc, fn {item, x}, acc ->
        if item == "O" and y != 0 do
          new_y =
            Enum.take_while((y - 1)..0, fn num ->
              acc[{x, num}] not in ["O", "#"]
            end)
            |> List.last()

          unless is_nil(new_y) do
            Map.put(acc, {x, new_y}, "O") |> Map.put({x, y}, ".")
          else
            acc
          end
        else
          acc
        end
      end)
    end)
    |> Enum.filter(&(elem(&1, 1) == "O"))
    |> Enum.map(fn {{_, y}, _} ->
      max_y - y + 1
    end)
    |> Enum.sum()
  end
end
