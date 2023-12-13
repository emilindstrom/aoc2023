defmodule Aoc2023.Day10.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day10/input.txt")
        |> String.split("\n")
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {row, y}, acc ->
          Map.merge(
            acc,
            Enum.reduce(Enum.with_index(String.graphemes(row)), %{}, fn {pipe, x}, acc ->
              if pipe == "." do
                acc
              else
                Map.merge(acc, %{{x, y} => pipe})
              end
            end)
          )
        end)

  def run do
    {{x, y}, _} = Enum.find(@data, fn {_, val} -> val == "S" end)

    find_next({x, y}, {x, y + 1}, @data[{x, y + 1}], 0)
  end

  def find_next({prev_x, prev_y}, {x, y} = coords, letter, step) do
    case letter do
      "S" ->
        IO.inspect("finished. total steps = #{step}, max = #{round(step / 2)}")

      "|" ->
        if prev_y == y - 1 do
          find_next(coords, {x, y + 1}, @data[{x, y + 1}], step + 1)
        else
          find_next(coords, {x, y - 1}, @data[{x, y - 1}], step + 1)
        end

      "L" ->
        if prev_y == y - 1 do
          find_next(coords, {x + 1, y}, @data[{x + 1, y}], step + 1)
        else
          find_next(coords, {x, y - 1}, @data[{x, y - 1}], step + 1)
        end

      "F" ->
        if prev_y == y + 1 do
          find_next(coords, {x + 1, y}, @data[{x + 1, y}], step + 1)
        else
          find_next(coords, {x, y + 1}, @data[{x, y + 1}], step + 1)
        end

      "J" ->
        if prev_y == y - 1 do
          find_next(coords, {x - 1, y}, @data[{x - 1, y}], step + 1)
        else
          find_next(coords, {x, y - 1}, @data[{x, y - 1}], step + 1)
        end

      "-" ->
        if prev_x == x - 1 do
          find_next(coords, {x + 1, y}, @data[{x + 1, y}], step + 1)
        else
          find_next(coords, {x - 1, y}, @data[{x - 1, y}], step + 1)
        end

      "7" ->
        if prev_y == y + 1 do
          find_next(coords, {x - 1, y}, @data[{x - 1, y}], step + 1)
        else
          find_next(coords, {x, y + 1}, @data[{x, y + 1}], step + 1)
        end
    end
  end
end
