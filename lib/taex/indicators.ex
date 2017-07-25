defmodule Taex.Indicators do
  require Logger 
  alias Taex.MovingAverage
  #
  # Aroon Indicator
  # Formula: http://www.investopedia.com/ask/answers/112814/what-aroon-indicator-formula-and-how-indicator-calculated.asp
  #
  #

  @doc """
  Formula: http://www.investopedia.com/ask/answers/112814/what-aroon-indicator-formula-and-how-indicator-calculated.asp
  Up part of the Aroon Indicator calculation
  Calculation: {((number of periods) - (number of periods since highest high)) / (number of periods)} x 100
  """
  def aroon_up(prices), do: aroon_up(prices, :standard)
  def aroon_up(prices, :reverse), do: aroon_up(Enum.reverse(prices), :standard)
  def aroon_up(prices, :standard) do
    number_of_periods = prices |> Enum.count
    high_period = calc_high(prices)
    aroon_calc(number_of_periods, high_period)
  end

  defp aroon_calc(number_of_periods, specified_period) do
    ((number_of_periods - specified_period) / number_of_periods) * 100
  end

  defp calc_high([], _, {_, high_index}), do: high_index
  defp calc_high([hd | tl]), do: calc_high(tl, hd, {2, 1})
  defp calc_high([hd | tl], high, {current_index, high_index}) do
    case hd > high do
      true -> calc_high(tl, hd, {current_index + 1, current_index})
      false -> calc_high(tl, high, {current_index + 1, high_index})
    end
  end

  @doc """
  Formula: http://www.investopedia.com/ask/answers/112814/what-aroon-indicator-formula-and-how-indicator-calculated.asp
  Down part of the Aroon Indicator calculation
  Calculation: {((number of periods) - (number of periods since lowest low)) / (number of periods)} x 100
  """
  def aroon_down(prices), do: aroon_down(prices, :standard)
  def aroon_down(prices, :reverse), do: aroon_down(Enum.reverse(prices), :standard)
  def aroon_down(prices, :standard) do
    number_of_periods = prices |> Enum.count
    low_period = calc_low(prices)
    aroon_calc(number_of_periods, low_period)
  end

  defp calc_low([], _, {_, low_index}), do: low_index
  defp calc_low([hd | tl]), do: calc_low(tl, hd, {2, 1})
  defp calc_low([hd | tl], low, {current_index, low_index}) do
    case hd < low do
      true -> calc_low(tl, hd, {current_index + 1, current_index})
      false -> calc_low(tl, low, {current_index + 1, low_index})
    end
  end
  defp calc_low(prices, low, count) do
    case prices do
      [hd | tl] when low == nil -> calc_low(tl, hd, count)
      [hd | tl] when hd < low -> calc_low(tl, hd, count)
      [hd | tl] -> calc_low(tl, low, count + 1)
      [hd] when low == nil -> count
      [hd] when hd < low -> count
      _ -> count
    end
  end

  #
  # MACD Indicator
  # Formula from: http://www.investopedia.com/terms/m/macd.asp
  # 26 Day EMA - 12 Day EMA = MACD
  #
  def macd(prices), do: macd(prices, :standard)
  def macd(prices, :reverse), do: macd(Enum.reverse(prices), :standard)
  def macd(prices, :standard) do
    fast = MovingAverage.exponential(12, prices)
    slow = MovingAverage.exponential(26, prices)
    slow - fast
  end
end