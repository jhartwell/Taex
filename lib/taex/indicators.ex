defmodule Taex.Indicators do
  def aroon_up(prices) do
    number_of_periods = prices |> Enum.count
    corrected_prices = prices |> Enum.reverse
    high_period = calc_high(prices, 0, 0)
    (number_of_periods - high_period) / (number_of_periods * 100)
  end

  defp calc_high(prices, high, count) do
    case prices do
      [hd | tl] when hd > high -> calc_high(tl, hd, count + 1)
      [hd | tl] -> calc_high(tl, high, count + 1)
      [hd] when hd > high -> count
      _ -> count
    end
  end

  def aroon_down(prices) do
    number_of_periods = prices |> Enum.count
    corrected_prices = prices |> Enum.reverse
    low_period = calc_low(prices, nil, 0)
    (number_of_periods - low_period) / (number_of_periods * 100)
  end

  defp calc_low(prices, low, count) do
    case prices do
      [hd | tl] when low == nil -> calc_low(tl, hd, count + 1)
      [hd | tl] when hd < low -> calc_low(tl, hd, count + 1)
      [hd | tl] -> calc_low(tl, low, count + 1)
      [hd] when low == nil -> count
      [hd] when hd < low -> count
      _ -> count
    end
  end
end