defmodule TaexTest.Bollinger do
  use ExUnit.Case

  test "basic bollinger test" do
    alias Taex.Points.Bollinger

    prices = Enum.to_list 1..20
    pt = Bollinger.calculate(prices)
    assert pt.upper == 22.03256
    assert pt.middle == 10.5
    assert pt.lower == -1.032563
end