defmodule Aoc2023.Day4.Pt2 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day4/input.txt")
        |> String.split("\n", trim: true)
        |> Enum.map(fn row ->
          [name, winning, numbers] = String.split(row, [":", "|"])
          my_numbers = String.split(numbers, " ", trim: true)
          [_, id] = String.split(name, " ", trim: true)
          winning_numbers = String.split(winning, " ", trim: true)
          {String.to_integer(id), my_numbers, winning_numbers}
        end)

  def run do
    Enum.reduce(@data, [], fn card, acc ->
      acc ++
        get_all_copys(
          [card],
          []
        )
    end)
    |> Enum.count()
  end

  def get_all_copys(cards, res) do
    new_res =
      Enum.map(cards, fn {name, my_numbers, winning_numbers} ->
        Enum.reduce(winning_numbers, {name, []}, fn num, {inc, acc} ->
          if num in my_numbers do
            {inc + 1, acc ++ [Enum.at(@data, inc)]}
          else
            {inc, acc}
          end
        end)
      end)
      |> Enum.map(fn {name, cards} -> cards end)
      |> List.flatten()

    if length(new_res) > 0 do
      get_all_copys(new_res, res ++ cards)
    else
      res ++ cards
    end
  end
end
