defmodule Taex.Other do
  use ExUnit.Case

  test "high helper" do
    import Taex.Helpers
    
    assert high([1,2,3,4,5]) == 5
    assert high(5)== 5
    assert high([1,1,4,2,1,5]) == 5
  end

  test "low helper" do
    import Taex.Helpers

    assert low([1,2,3,4,5]) == 1
    assert low(1) == 1
    assert low([1,4,2,6,8,234,1,2,4323]) == 1
  end
end