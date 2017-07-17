defmodule Taex.Oscillators do
  def aroon(prices) do
    import Taex.Indicators
    %Taex.AroonPoint {
      high: aroon_up(prices),
      low: aroon_down(prices)
    }
  end

  def macd do
    
  end
end