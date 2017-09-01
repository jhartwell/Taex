defmodule TaexTest do
  use ExUnit.Case
  doctest Taex

  alias Taex.MovingAverage
  alias Taex.Points.Bollinger

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

  test "weighted moving average" do
    prices  = [{1,1}, {2,1}, {3,1}]
    wma = MovingAverage.weighted prices
    assert 6 == wma

    prices = [{35, 0.25}, {25, 0.34}, {50, 0.10}]
    expected = (35 * 0.25) + (25 * 0.34) + (50 * 0.10)
    wma = MovingAverage.weighted prices
    assert expected == wma
  end 

  test "exponential moving average" do
    prices = Enum.to_list 1..6 |> Enum.map( fn x -> x / 1 end)
    
    ema = MovingAverage.exponential(3, prices)
    assert 5.03125 == ema
  end

  test "double exponential moving average" do
    prices = Enum.to_list 1..6 |> Enum.map( fn x -> x / 1 end)
    
    ema = MovingAverage.double_ema(3, prices)
    assert 5.921875 == ema
  end

  test "triple exponential moving average" do
    prices = Enum.to_list 1..6 |> Enum.map( fn x -> x / 1 end)
    
    ema = MovingAverage.triple_ema(3, prices)
    assert 6.0390625 == ema
  end

  test "bollinger band" do
    prices = Enum.to_list 1..50
    bb = Bollinger.calculate(prices)
    assert bb.upper != bb.lower
  end
end
