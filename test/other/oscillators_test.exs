defmodule Taex.OscillatorsTests do
    use ExUnit.Case
  
    @prices [82.15,81.89,83.03,83.30,83.85,83.90,83.33,84.30,84.84,85.00,85.90,86.58,86.98,88.00,87.87]

    alias Taex.Oscillators
    test "stochastic" do
      assert Oscillators.stochastic(@prices) == 97.872340425532
    end

    test "stocastic_ma" do
      assert Oscillators.stocastic_ma(@prices) == 82.35666666666667
    end

  end