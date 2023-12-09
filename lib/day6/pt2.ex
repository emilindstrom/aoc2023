defmodule Aoc2023.Day6.Pt2 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day6/input.txt")
        |> String.split("\n")
        |> Enum.map(fn row ->
          tl(String.split(row, " ", trim: true)) |> Enum.join() |> String.to_integer()
        end)

  def run do
    time = Enum.at(@data, 0)
    distance = Enum.at(@data, 1)

    chunk_size = 100_00

    breaking_point_head =
      Enum.reduce_while(Enum.take_every(1..time, chunk_size), [], fn second, acc ->
        if second * (time - second) <= distance do
          {:cont, acc ++ [second * (time - second)]}
        else
          {:halt, second}
        end
      end)

    head =
      Enum.reduce_while((breaking_point_head - chunk_size)..breaking_point_head, [], fn second,
                                                                                        acc ->
        if second * (time - second) <= distance do
          {:cont, acc ++ [second * (time - second)]}
        else
          {:halt, second}
        end
      end)

    breaking_point_tail =
      Enum.reduce_while(Enum.take_every(time..1, chunk_size), [], fn second, acc ->
        if second * (time - second) <= distance do
          {:cont, acc ++ [second * (time - second)]}
        else
          {:halt, second}
        end
      end)

    tail =
      Enum.reduce_while((breaking_point_tail + chunk_size)..breaking_point_tail, [], fn second,
                                                                                        acc ->
        if second * (time - second) <= distance do
          {:cont, acc ++ [second * (time - second)]}
        else
          {:halt, second}
        end
      end)

    tail = time - tail

    time - (head + tail) + 1
  end
end
