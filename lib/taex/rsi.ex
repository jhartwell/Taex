defmodule Taex.RSI do
  def calculateRSI([]), do: 0
  def calculateRSI(prices) when is_list(prices) do
    1
  end

  def averageGain(prices) when is_list(prices) do
    
  end

  def averageLoss([]), do: 0
  def averageLoss(prices) when is_list(prices) do
    totalLosses = loss(prices)
    totalLosses / Enum.count(prices)
  end

  defp loss([_]), do: 0
  defp loss([head|tail]) when hd(tail) >= head, do: loss(tail)
  defp loss([head|tail]) when hd(tail)< head, do: head - hd(tail) + loss(tail)

end
