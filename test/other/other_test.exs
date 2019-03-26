defmodule Taex.Other do
  use ExUnit.Case

  alias Taex.Helpers
  test "high helper" do
    assert Helpers.high([1,2,3,4,5]) == 5
    assert Helpers.high(5)== 5
    assert Helpers.high([1,1,4,2,1,5]) == 5
    assert Helpers.high(3, [3,2,5,1,232,15,4,3]) == 15
  end

  test "low helper" do
    assert Helpers.low([1,2,3,4,5]) == 1
    assert Helpers.low(1) == 1
    assert Helpers.low([1,4,2,6,8,234,1,2,4323]) == 1
    assert Helpers.low(3, [3,2,5,1,232,15,4,3]) == 3
  end
end