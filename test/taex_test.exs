defmodule TaexTest do
  use ExUnit.Case
  doctest Taex

  alias Taex.MovingAverage
  alias Taex.MovingAverage.{VolumeWeightedMovingAverage}
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

    ema = MovingAverage.exponential(3, 6, 4.0625)
    assert 5.03125 == ema
  end

  test "double exponential moving average" do
    prices = Enum.to_list 1..6 |> Enum.map( fn x -> x / 1 end)
    
    ema = MovingAverage.double_ema(3, prices)
    assert %MovingAverage.DoubleEma{ema: 5.03125, ema_2: 4.140625, value: 5.921875} == ema

    ema = MovingAverage.double_ema(3, 6, %MovingAverage.DoubleEma{ema: 4.0625, ema_2: 3.25, value: 0})
    assert %MovingAverage.DoubleEma{ema: 5.03125, ema_2: 4.140625, value: 5.921875} == ema
  end

  test "triple exponential moving average" do
    prices = Enum.to_list 1..6 |> Enum.map( fn x -> x / 1 end)
    
    ema = MovingAverage.triple_ema(3, prices)
    assert %MovingAverage.TripleEma{ema: 5.03125, ema_2: 4.140625, ema_3: 3.3671875, value: 6.0390625} == ema

    ema = MovingAverage.triple_ema(3, 6, %MovingAverage.TripleEma{ema: 4.0625, ema_2: 3.25, ema_3: 2.59375, value: 0})
    assert %MovingAverage.TripleEma{ema: 5.03125, ema_2: 4.140625, ema_3: 3.3671875, value: 6.0390625} == ema
  end

  test "volume weighted moving average" do
    prices = [1,2,3,4,5,6]
    volumes = [2,3,4,5,6,7]

    vwma = %VolumeWeightedMovingAverage{prices: prices, volumes: volumes, periods: 6}    

    vwma = VolumeWeightedMovingAverage.update(vwma, 7, 8)

    assert (2 * 3 + 3 * 4 + 4 * 5 + 5 * 6 + 6 * 7 + 7 * 8)/Enum.sum(3..8) == vwma.value
  end

  test "bollinger band" do
    prices = Enum.to_list 1..50
    bb = Bollinger.calculate(prices)
    assert bb.upper != bb.lower
  end
end
