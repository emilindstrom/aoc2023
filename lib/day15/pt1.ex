defmodule Aoc2023.Day15.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day15/input.txt")
        |> String.split(",")

  def run do
    Enum.map(@data, fn string ->
      String.graphemes(string)
      |> Enum.reduce(0, fn char, acc ->
        <<num::utf8>> = char
        rem((acc + num) * 17, 256)
      end)
    end)
    |> Enum.sum()
  end
end
