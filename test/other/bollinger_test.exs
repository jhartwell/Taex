defmodule TaexTest.Bollinger do
  use ExUnit.Case
  alias Taex.Points.Bollinger

  test "basic bollinger test" do
    prices = Enum.to_list 1..20
    pt = Bollinger.calculate(prices)
    assert pt.upper == 22.032562594670797
    assert pt.middle == 10.5
    assert pt.lower == -1.0325625946707966
  end

  test "bollinger with price data" do
    prices = [4261.37, 4289.60, 4315.62, 4299.56, 4287.54, 4252.00, 4234.25, 4238.32, 4281.31, 4263.76, 4268.02, 4310.01, 4337.98, 4319.10, 4346.01,
    4310.00, 4306.00, 4288.75, 4350.63, 4409.01, 4450.01, 4452.22, 4456.45, 4459.86, 4460.00, 4454.34 ,4467.98, 4449.98, 4438.99 ,4427.56]

    pt = Bollinger.calculate(prices)
    assert pt.lower == 4249.730339866039
    assert pt.middle == 4388.1449999999995
    assert pt.upper == 4526.55966013396
  end
end