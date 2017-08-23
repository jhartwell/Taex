defmodule Taex.Points.Bollinger do
  alias Statistics
  alias Taex.MovingAverage

  @moduledoc """
  The calculation for this was taken from http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:bollinger_bands
  Bollinger Band is a registered trademark of John Bollinger. 
  """

  @type t :: %{upper: float, middle: float, lower: float}
  defstruct [:upper, :middle, :lower]


  def calculate(prices) do
    last_twenty = prices |> Enum.reverse |> Enum.take(20)
    %Taex.Points.Bollinger {
      upper: bollinger_band(last_twenty, fn x, y -> x + y end),
      middle: bollinger_middle_band(last_twenty),
      lower: bollinger_band(last_twenty, fn x, y -> x - y end)
    }
  end

  @doc """
  The middle band is the 20 simple moving average of the prices
  """
  @spec bollinger_middle_band([float]) :: float
  defp bollinger_middle_band(prices) do
    MovingAverage.simple(20, prices)
  end

  @doc """
  Calculates the band for bollinger. The function that is provided is the basis of which band this is calculating. 
  If fn x y -> x + y end is passed in then it will calculate the upper band
  If fn x y -> x - y end is passed in then it will calculate the lower band
  """
  @spec bollinger_band([float], function) :: float
  defp bollinger_band(prices, f) when is_function(f) and is_list(prices) do
    stdev = Statistics.stdev(prices)
    f.(MovingAverage.simple(20, prices), (stdev * 2))
  end
end