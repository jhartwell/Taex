defmodule Taex.MovingAverage do

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
  def exponential(_, []), do: 0
  def exponential(n, prices) do
    k = weighting_multiplier(n)
    [head | _] = exp_calc(k, prices)
    head
  end

  @spec double_ema(integer, [float]) :: float
  def double_ema(_, []), do: 0
  def double_ema(n, prices) do
    k = weighting_multiplier(n)
    emas = exp_calc(k, prices)
    ema_2 = exp_calc(k, emas |> Enum.reverse) |> Enum.at(0)
    ema = emas |> Enum.at(0)
    2 * ema - ema_2
  end

  @spec triple_ema(integer, [float]) :: float
  def triple_ema(_, []), do: 0
  def triple_ema(n, prices) do
    k = weighting_multiplier(n)
    emas = exp_calc(k, prices)
    ema_2s = exp_calc(k, emas |> Enum.reverse)
    ema_3 = exp_calc(k, ema_2s |> Enum.reverse) |> Enum.at(0)
    ema = emas |> Enum.at(0)
    ema_2 = ema_2s |> Enum.at(0)
    (3 * ema - 3 * ema_2) + ema_3
  end

  @spec weighting_multiplier(integer) :: float
  defp weighting_multiplier(n) do
    2 / (n + 1)
  end 

  @spec exp_calc(integer, [float], [float]) :: [float]
  defp exp_calc(_, [], emas), do: emas 
  defp exp_calc(k, [p | tl], [ema_head | ema_tail]) do
    exp_calc(k, tl, [(p * k) + (ema_head * (1 - k))] ++ [ema_head] ++ ema_tail)
  end
  defp exp_calc(k, [hd | tl]), do: exp_calc(k, tl, [hd])

  @spec weighted([{float, float}]) :: float
  def weighted(items) do
    Enum.reduce(items, 0, fn {a, b} , acc -> acc + (a * b) end)
  end

end