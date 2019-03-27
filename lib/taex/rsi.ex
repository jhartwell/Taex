defmodule Taex.RSI do
  def calculateRSI([]), do: 0
  def calculateRSI(prices) when is_list(prices) do
    IO.puts(Enum.count(prices))
    rs = averageGain(prices) / averageLoss(prices)
    100-100/(1 + rs)
  end

  def averageGain([]), do: 0
  def averageGain(prices) when is_list(prices) do
    totalGaines = gain(prices)
    totalGaines / Enum.count(prices)
  end

  def averageLoss([]), do: 0
  def averageLoss(prices) when is_list(prices) do
    totalLosses = loss(prices)
    totalLosses / Enum.count(prices)
  end

  defp loss([_]), do: 0
  defp loss([head|tail]) when hd(tail) >= head, do: loss(tail)
  defp loss([head|tail]) when hd(tail) < head, do: head - hd(tail) + loss(tail)

  defp gain([_]), do: 0
  defp gain([head|tail]) when hd(tail) <= head, do: gain(tail)
  defp gain([head|tail]) when hd(tail) > head,  do: hd(tail) - head + gain(tail)

end
