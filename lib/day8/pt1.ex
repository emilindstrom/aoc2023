defmodule Aoc2023.Day8.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day8/input.txt")
        |> String.split("\n", trim: true)

  def run do
    [instructions | nodes] = @data
    instructions = String.graphemes(instructions)

    nodes =
      Enum.reduce(nodes, %{}, fn node, acc ->
        [[from], [left], [right]] = Regex.scan(~r/(?:[A-Z]{3})/, node)
        Map.merge(acc, %{from => {left, right}})
      end)

    repeat(instructions, nodes, "AAA", 0)
  end

  def repeat(instructions, nodes, starting_value, step) do
    if starting_value == "ZZZ" do
      IO.inspect("#{starting_value}, #{step}")
    else
      res =
        Enum.reduce_while(instructions, {starting_value, step}, fn instruction,
                                                                   {starting_value, step} ->
          left_or_right = if instruction == "L", do: 0, else: 1
          new_start_value = elem(nodes[starting_value], left_or_right)

          if new_start_value == "ZZZ" do
            {:halt, step + 1}
          else
            {:cont, {new_start_value, step + 1}}
          end
        end)

      case res do
        {new_start_value, step} ->
          repeat(instructions, nodes, new_start_value, step)

        step ->
          IO.inspect("step #{step}")
      end
    end
  end
end
