defmodule Taex.MovingAverage do
  @spec simple(integer, [float]) :: float
  def simple(n, items \\ []) do
    sum = items |> Enum.reverse |> Enum.take(n) |> Enum.sum
    sum / n
  end

  def exponential(n, []), do: 0
  def exponential(n, prices), do: exponential(n, prices, :standard)
  def exponential(n, prices, :reverse), do: exponential(n, Enum.reverse(prices), :standard)
  def exponential(n, prices, :standard) do
    n_prices = Enum.take(prices, n)
    k = 2 / (n + 1)
    exp_calc(k, n_prices)
  end


  defp exp_calc(_, {[], ema}), do: ema
  defp exp_calc(k, [hd | tl]), do: exp_calc(k, {tl, hd})
  defp exp_calc(k, {[p | tl], ema}) do
    exp_calc(k, {tl, (p * k) + (ema * (1 - k))})
  end
end