defmodule Taex.RsiTests do
  use ExUnit.Case
  alias Taex.RSI

  @prices [
    44.3389,
    44.0902,
    44.1497,
    43.6124,
    44.3278,
    44.8264,
    45.0955,
    45.4245,
    45.8433,
    46.0826,
    45.8931,
    46.0328,
    45.614,
    46.282
  ]

  test "calculate RSI" do
    # there is should be somthing like AssertAlmostEqual in Python
    assert Float.round(RSI.calculateRSI(@prices), 2) == 70.53
  end

  test "average gain" do
    assert RSI.averageGain([10, 20, 30, 40]) == 7.5
    assert RSI.averageGain([3, 2, 1]) == 0
    assert RSI.averageGain([]) == 0
    assert Float.round(RSI.averageGain(@prices), 4) == 0.2384
  end

  test "average loss" do
    assert RSI.averageLoss([30, 20, 10, 0]) == 7.5
    assert RSI.averageLoss([1, 2, 3]) == 0
    assert RSI.averageLoss([]) == 0
    assert Float.round(RSI.averageLoss(@prices), 4) == 0.0996
  end
end
