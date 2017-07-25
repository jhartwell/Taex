defmodule Taex.MovingAverage do
  alias Taex.Helpers

  @doc """
  Calculates the simple moving average which is just the sum of the items passed in divided by the number of items 
  """
  @spec simple(integer, [float]) :: float
  def simple(items) when is_list(items), do: Enum.sum(items) / Enum.count(items)
  def simple(0, _), do: 0
  def simple(n, items) when is_list(items) do
    sum = items |> Enum.take(n) |> Enum.sum
    (sum / n)
  end

  @spec exponential(integer, [float]) :: float
  def exponential(n, []), do: 0
  def exponential(n, prices) do
    n_prices = Enum.take(prices, n)
    k = 2 / (n + 1)
   exp_calc(k, n_prices)
  end

  @spec exp_calc(integer, {[float], float}) :: float
  defp exp_calc(_, {[], ema}), do: ema
  defp exp_calc(k, [hd | tl]), do: exp_calc(k, {tl, hd})
  defp exp_calc(k, {[p | tl], ema}) do
    exp_calc(k, {tl, (p * k) + (ema * (1 - k))})
  end
end