defmodule Aoc2023.Day5.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day5/input.txt")
        |> String.split("\n")
        |> Enum.chunk_by(&(&1 == ""))
        |> Enum.reject(&(&1 == [""]))

  def run do
    [[seeds] | rest] = @data
    [_ | seeds] = String.split(seeds, [":", " "], trim: true)

    mappings =
      Enum.reduce(rest, %{}, fn [name | mappings], acc ->
        Map.merge(acc, %{
          name =>
            Enum.map(mappings, fn map ->
              String.split(map, " ") |> Enum.map(&String.to_integer/1)
            end)
        })
      end)

    steps = [
      "seed-to-soil map:",
      "soil-to-fertilizer map:",
      "fertilizer-to-water map:",
      "water-to-light map:",
      "light-to-temperature map:",
      "temperature-to-humidity map:",
      "humidity-to-location map:"
    ]

    Enum.map(seeds, fn seed ->
      Enum.reduce(steps, String.to_integer(seed), fn step, acc ->
        case Enum.find(mappings[step], fn [_dest_range, source_range, range_length] ->
               source_range + range_length - 1 >= acc and source_range <= acc
             end) do
          nil ->
            acc

          [dest_range, source_range, range_length] ->
            diff = dest_range - source_range

            acc + diff
        end
      end)
    end)
    |> Enum.min()
  end
end
