defmodule Taex.Oscillators do

  @doc """
    Calculates the Aroon Oscillator. This captures the high and the low Aroon indicators
  """
  @spec aroon([float]) :: Taex.AroonPoint.t
  def aroon(prices) do
    import Taex.Indicators
    %Taex.AroonPoint {
      high: aroon_up(prices),
      low: aroon_down(prices)
    }
  end

  @doc """
   Calculates the oscillator for the moving average convergence diververgence (MACD). This is
   the MACD indicator and the exponential moving average (EMA) of the last 9 periods of MACD
  """
  @spec macd([float], [float]) :: Taex.MacdPoint.t
  def macd(prices, ma_macd) do
    avg_macd = Taex.Indicators.macd prices
    ema_macd = Taex.MovingAverage.exponential(9, ma_macd)

    %Taex.MacdPoint {
      macd: avg_macd,
      ema_macd: ema_macd
    }
  end
end