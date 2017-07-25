defmodule TaexTest do
  use ExUnit.Case
  doctest Taex

  alias Taex.MovingAverage
  alias Taex.Helpers
  def sma(items, count \\ 0) do
    case count do
      0 -> Enum.sum(items) / Enum.count(items)
      i -> (items |> Enum.take(i) |> Enum.sum) / i
    end
  end

  test "simple moving average" do
    prices = Enum.to_list 1..10 |> Enum.map( fn x -> x / 1 end)

    ma = sma(prices,5)
    avg = MovingAverage.simple 5, prices
    assert ma == avg

    prices = Enum.to_list 1..100 |> Enum.map( fn x -> x / 1 end)
    ma = sma(prices,20)
    avg = MovingAverage.simple 20, prices
    assert ma == avg
  end

end
