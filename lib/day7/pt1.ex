defmodule Aoc2023.Day7.Pt1 do
  @data File.read!("/Users/emilindstrom/code/elixir/aoc2023/lib/day7/input.txt")
        |> String.split("\n")

  @sort_order_card ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

  @sort_order_type [[5], [4, 1], [3, 2], [3, 1, 1], [2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1, 1]]

  def run do
    hands =
      Enum.map(@data, fn hand ->
        [hand, money] = String.split(hand, " ")

        pairs =
          calculate_hand(hand)
          |> Enum.to_list()
          |> Enum.map(fn {_, numbers} -> length(numbers) end)
          |> Enum.sort(:desc)

        {hand, money, pairs}
      end)
      |> Enum.sort_by(
        fn {hand, _money, _num} ->
          String.graphemes(hand)
        end,
        fn left, right ->
          Enum.reduce_while(0..(length(left) - 1), false, fn i, acc ->
            left = Enum.find_index(@sort_order_card, fn e -> e == Enum.at(left, i) end)
            right = Enum.find_index(@sort_order_card, fn e -> e == Enum.at(right, i) end)

            if left == right do
              {:cont, false}
            else
              if left > right do
                {:halt, true}
              else
                {:halt, false}
              end
            end
          end)
        end
      )
      |> Enum.sort_by(fn {hand, money, num} ->
        Enum.find_index(@sort_order_type, fn e ->
          e == num
        end)
      end)

    Enum.reverse(hands)
    |> Enum.with_index()
    |> Enum.map(fn {{hand, money, num}, i} ->
      String.to_integer(money) * (i + 1)
    end)
    |> Enum.sum()
  end

  def calculate_hand(hand) do
    String.graphemes(hand)
    |> Enum.group_by(fn card -> card end)
  end
end
