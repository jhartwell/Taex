defmodule Taex.OscillatorsTests do
    use ExUnit.Case
  
    alias Taex.Oscillators
    test "stochastic" do
      assert Oscillators.stochastic([82.15,81.89,83.03,83.30,83.85,83.90,83.33,84.30,84.84,85.00,85.90,86.58,86.98,88.00,87.87]) == 97.872340425532
    end

    test "stocastic_ma" do
      assert Oscillators.stocastic_ma([85.00,85.90,86.58,86.98,88.00,87.87]) == 85.82666666666667
    end

  end