defmodule Taex.Points.Macd do
  @moduledoc """
  MACD Indicator, which is the 26 day exponential moving average subtracted by the 12 day exponential moving average. Formula was taken from:
  Formula from: http://www.investopedia.com/terms/m/macd.asp
  """
  @type t :: %{value: float}
  defstruct [:value]

  def calculate(prices) do
    %Taex.Points.Macd {
      value: macd(prices)
    }
  end

  @doc """
  This will retrieve the oscillator for the MACD. This is calculated by taking the exponential moving average of the last 9 MACD entries
  """
  @spec get_oscillator([Taex.Points.Macd.t]) :: float
  def get_oscillator(macd) do
    macd_values = Enum.reduce(macd, fn acc, x -> acc ++ [x.value] end)
    MovingAverage.exponential(9, macd)
  end

  defp macd(prices) do
    fast = MovingAverage.exponential(12, prices)
    slow = MovingAverage.exponential(26, prices)
    slow - fast
  end
end