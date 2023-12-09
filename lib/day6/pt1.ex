defmodule Aoc2023.Day6.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day6/input.txt")
        |> String.split("\n")
        |> Enum.map(fn row ->
          tl(String.split(row, " ", trim: true)) |> Enum.map(&String.to_integer/1)
        end)
        |> Enum.zip()

  def run do
    Enum.map(@data, fn {time, distance} ->
      Enum.reduce(1..time, [], fn second, acc ->
        if second * (time - second) > distance do
          acc ++ [second * (time - second)]
        else
          acc
        end
      end)
      |> Enum.count()
    end)
    |> Enum.reduce(fn num, acc -> num * acc end)
  end
end
