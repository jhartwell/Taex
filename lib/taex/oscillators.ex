defmodule Taex.Oscillators do
  alias Taex.MovingAverage
  @doc """
    Calculates the Aroon Oscillator. This captures the high and the low Aroon indicators
  """
  @spec aroon([float]) :: Taex.AroonPoint.t
  def aroon(prices) do
    import Taex.Indicators
    %Taex.Points.Aroon {
      high: aroon_up(prices),
      low: aroon_down(prices)
    }
  end

  @doc """
   Calculates the oscillator for the moving average convergence diververgence (MACD). This is
   the MACD indicator and the exponential moving average (EMA) of the last 9 periods of MACD
  """
  @spec macd([Taex.Points.Macd.t]) :: float
  def macd(macd) do
    macd_values = Enum.reduce(macd, fn acc, x -> acc ++ x.value end)
    MovingAverage.exponential(9, macd_values)
  end

  
  @doc """
  Calculates the stochastic current market rate for the given list of prices (%K)
  """
  @spec stochastic([float]) :: float
  def stochastic(prices) when is_list(prices) do
    c = Enum.at(prices, (prices |> Enum.count) - 1)
    l14 = Taex.Helpers.low(14, prices)
    h14 = Taex.Helpers.high(14, prices)
    100 * (c - l14)/(h14 - l14)
  end

  @doc """
  Calculates the 3 day moving average of stocastic current market rates (%D)
  """
  @spec stocastic_ma([float]) :: float
  def stocastic_ma(stochastics) when is_list(stochastics) do
    MovingAverage.simple(3, stochastics)
  end

end