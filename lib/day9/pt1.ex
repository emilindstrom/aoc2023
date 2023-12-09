defmodule Aoc2023.Day9.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day9/input.txt")
        |> String.split("\n", trim: true)

  def run do
    @data
    |> Enum.map(fn row ->
      numbers = String.split(row, " ") |> Enum.map(&String.to_integer/1)

      reccur([numbers])
    end)
    |> Enum.map(fn list -> Enum.reduce(list, 0, fn list, acc -> List.last(list) + acc end) end)
    |> Enum.sum()
  end

  def reccur(numbers) do
    if Enum.all?(List.last(numbers), &(&1 == 0)) do
      numbers
    else
      last = List.last(numbers)
      length = length(last)

      new_numbers =
        numbers ++
          [
            Enum.map(0..(length - 2), fn i ->
              diff = Enum.at(last, i + 1) - Enum.at(last, i)
            end)
          ]

      reccur(new_numbers)
    end
  end
end
