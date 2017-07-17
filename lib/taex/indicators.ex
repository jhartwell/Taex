defmodule Taex.Indicators do
  require Logger 

  #
  # Aroon Indicator
  # Formula: http://www.investopedia.com/ask/answers/112814/what-aroon-indicator-formula-and-how-indicator-calculated.asp
  # {((number of periods) - (number of periods since highest high)) / (number of periods)} x 100
  #
  def aroon_up(prices) do
    number_of_periods = prices |> Enum.count
    corrected_prices = prices |> Enum.reverse
    high_period = calc_high(corrected_prices, nil, 1)
    aroon_calc(number_of_periods, high_period)
  end

  def aroon_calc(number_of_periods, specified_period) do
    ((number_of_periods - specified_period) / number_of_periods) * 100
  end

  defp calc_high(prices, high, count) do
    case prices do
      [hd | tl] when high == nil -> calc_high(tl, hd, count)
      [hd | tl] when hd > high -> calc_high(tl, hd, count + 1)
      [hd | tl] -> calc_high(tl, high, count)
      [hd] when hd > high -> count
      _ -> count
    end
  end

  def aroon_down(prices) do
    number_of_periods = prices |> Enum.count
    corrected_prices = prices |> Enum.reverse
    low_period = calc_low(corrected_prices, nil, 1)
    aroon_calc(number_of_periods, low_period)
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
  def macd(prices) do
    import Taex.MovingAverage
    fast = exponential(12, prices)
    slow = exponential(26, prices)
    slow - fast
  end
end