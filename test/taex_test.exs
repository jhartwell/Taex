defmodule TaexTest do
  use ExUnit.Case
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

  test "Aroon indicator" do
    import Taex.Indicators

    #
    # Case when the high is the latest price
    #
    prices = [1,2,3,4,5]
    value = aroon_up prices
    expected_value = (5 - 1) / (100 * 5)
    assert value == expected_value

    #
    # Case when the low is the latest price
    #
    value = aroon_down prices
    expected_value = (5 - 1) / (100 * 5)
    assert value == expected_value

    #
    # Case when the high is the earliest price
    #
    prices = [5,4,3,2,1]
    value = aroon_up prices
    expected_value = (5 - 5) / (100  * 5)
    assert value == expected_value

    #
    # Case when the low is the earliest price
    #
    value = aroon_down prices
    expected_value = (5 - 5) / (100 * 5)
    assert value == expected_value
  end

  test "Aroon Oscillator" do
    import Taex.Indicators
    alias Taex.Oscillators
    #
    # Case when the high is the latest price
    #
    prices = [1,2,3,4,5]
    value = aroon_up prices
    up_expected_value = (5 - 1) / (100 * 5)

    #
    # Case when the low is the latest price
    #
    value = aroon_down prices
    down_expected_value = (5 - 1) / (100 * 5)

    oscillator = Oscillators.aroon prices
    assert oscillator.high == up_expected_value
    assert oscillator.low == down_expected_value
  end
end
