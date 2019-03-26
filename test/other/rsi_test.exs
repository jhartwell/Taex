defmodule Taex.RsiTests do
  use ExUnit.Case
  alias Taex.RSI

  test "average loss" do
    assert RSI.averageLoss([30, 20, 10, 0]) == 7.5
    assert RSI.averageLoss([1, 2, 3]) == 0
    assert RSI.averageLoss([]) == 0
  end
end
