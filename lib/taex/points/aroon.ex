defmodule Taex.Points.Aroon do
  @moduledoc """
  Single point in time for the Aroon indicator. The formula used can be found here:
  http://www.investopedia.com/ask/answers/112814/what-aroon-indicator-formula-and-how-indicator-calculated.asp
  """

  @type t :: %{high: float, low: float}
  
  defstruct [:high, :low]

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
  def calculate(prices, n \\ 20) when is_list(prices) do
    %Taex.Points.Aroon {
      high: aroon_up(prices, n),
      low: aroon_down(prices, n)
    }
  end

  defp aroon_up(prices, n) when is_list(prices) do
    usable_prices = prices |> Enum.reverse |> Enum.take(n)
    high_period = calc_high(usable_prices)
    aroon_calc(n, high_period)
  end

  defp aroon_calc(number_of_periods, specified_period) do
    case {number_of_periods, specified_period} do
      {n, p} when (n - 1) == p -> 0
      {n, p} when p == 0 -> 100
      {n, p} -> ((number_of_periods - specified_period) / number_of_periods) * 100
    end
  end

  defp calc_high([hd | tl]), do: calc_high(tl, hd, {1, 0})
  defp calc_high([], _, {_, high_index}), do: high_index
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
  defp aroon_down(prices, n) when is_list(prices) do
    usable_prices = prices |> Enum.reverse |> Enum.take(n)
    low_period = calc_low(usable_prices)
    aroon_calc(n, low_period)
  end

  defp calc_low([hd | tl]), do: calc_low(tl, hd, {1, 0})
  defp calc_low([], _, {_, low_index}), do: low_index
  defp calc_low([hd | tl], low, {current_index, low_index}) do
    case hd < low do
      true -> calc_low(tl, hd, {current_index + 1, current_index})
      false -> calc_low(tl, low, {current_index + 1, low_index})
    end
  end
end