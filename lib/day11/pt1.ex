defmodule Aoc2023.Day11.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day11/input.txt")
        |> String.split("\n")
        |> Enum.map(&String.graphemes/1)

  def run do
    points =
      Enum.reduce(@data, [], fn row, acc ->
        duplicate_row_if_empty(row, acc)
      end)
      |> Enum.zip_with(& &1)
      |> Enum.reduce([], fn row, acc ->
        duplicate_row_if_empty(row, acc)
      end)
      |> Enum.zip_with(& &1)
      |> Enum.with_index()
      |> Enum.reduce([], fn {row, y}, acc ->
        acc ++
          Enum.reduce(Enum.with_index(row), [], fn {value, x}, acc ->
            if value != "." do
              acc ++ [{x, y, value}]
            else
              acc
            end
          end)
      end)

    Enum.reduce(Enum.with_index(points, 1), %{}, fn {{x1, y1, _}, num1}, acc_y ->
      res =
        Enum.reduce(Enum.with_index(points, 1), %{}, fn {{x2, y2, _}, num2}, acc ->
          if num1 != num2 and is_nil(acc_y[{num2, num1}]) do
            Map.merge(acc, %{{num1, num2} => abs(Kernel.-(x1, x2)) + abs(Kernel.-(y1, y2))})
          else
            acc
          end
        end)

      Map.merge(acc_y, res)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def duplicate_row_if_empty(row, acc) do
    if Enum.all?(row, &(&1 == ".")) do
      acc ++ [row] ++ [row]
    else
      acc ++ [row]
    end
  end
end
