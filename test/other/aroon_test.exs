defmodule TaexTest.Aroon do
  @moduledoc """
  The TTR package in R (https://cran.r-project.org/web/packages/TTR/index.html) is used to perform all calculations
  to get the expected value for the Aroon indicator. That result is then used to populate the expected value in each 
  of the unit test cases
  """
  use ExUnit.Case

  test "basic Aroon point low to high" do
    alias Taex.Points.Aroon
    prices = Enum.to_list 1..20
   
    pt = Aroon.calculate(prices)
    assert pt.high == 100
    assert pt.low == 0
  end

  test "basic Aroon point high to low" do
    alias Taex.Points.Aroon
    prices = Enum.to_list 20..1

    pt = Aroon.calculate(prices)
    assert pt.high == 0
    assert pt.low == 100
  end

  test "Aroon with real quotes" do
    alias Taex.Points.Aroon
    prices = [4261.37, 4289.60, 4315.62, 4299.56, 4287.54, 4252.00, 4234.25, 4238.32, 4281.31, 4263.76, 4268.02, 4310.01, 4337.98, 4319.10, 4346.01,
    4310.00, 4306.00, 4288.75, 4350.63, 4409.01, 4450.01, 4452.22, 4456.45, 4459.86, 4460.00, 4454.34 ,4467.98, 4449.98, 4438.99 ,4427.56]

    pt = Aroon.calculate(prices)
    assert pt.high == 85
    assert pt.low == 0
  end

end