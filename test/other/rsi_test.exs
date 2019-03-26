defmodule Taex.RsiTests do
  use ExUnit.Case
  alias Taex.RSI

  test "average gain" do
    assert RSI.averageGain([10, 20, 30, 40]) == 7.5
    assert RSI.averageGain([3, 2, 1]) == 0
    assert RSI.averageGain([]) == 0
  end

  test "average loss" do
    assert RSI.averageLoss([30, 20, 10, 0]) == 7.5
    assert RSI.averageLoss([1, 2, 3]) == 0
    assert RSI.averageLoss([]) == 0
  end
end
