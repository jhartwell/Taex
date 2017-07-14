defmodule TaexTest do
  use ExUnit.Case
  require Logger
  doctest Taex

  test "simple moving average" do
    import Taex.MovingAverage
    avg = simple 5, 1..10
    assert avg == 8

    avg = simple 20, 1..100
    assert avg == 90.5
  end

  test "exponential moving average" do
    import Taex.MovingAverage
    ema = exponential 5, [1..5]
    assert ema == 1
  end
end
