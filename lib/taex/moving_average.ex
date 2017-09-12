defmodule Taex.MovingAverage do
  defmodule DoubleEma do
    defstruct [:ema, :ema_2, :value]
  end

  defmodule TripleEma do
    defstruct [:ema, :ema_2, :ema_3, :value]
  end

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
    [head | _] = exp_calc(n, prices)
    head
  end
  def exponential(n, price, previous_ema) do
    exp_calc(n, [price], [previous_ema]) |> Enum.at(0)
  end

  @spec double_ema(integer, [float]) :: float
  def double_ema(_, []), do: 0
  def double_ema(n, prices) do
    emas = exp_calc(n, prices)
    ema_2 = exp_calc(n, emas |> Enum.reverse) |> Enum.at(0)
    ema = emas |> Enum.at(0)
    %DoubleEma{ema: ema, ema_2: ema_2, value: 2 * ema - ema_2}
  end
  def double_ema(n, price, %DoubleEma{ema: previous_ema, ema_2: previous_ema_2}) do
    ema = exp_calc(n, [price], [previous_ema]) |> Enum.at(0)
    ema_2 = exp_calc(n, [ema], [previous_ema_2]) |> Enum.at(0)
    %DoubleEma{ema: ema, ema_2: ema_2, value: 2 * ema - ema_2}
  end

  @spec triple_ema(integer, [float]) :: float
  def triple_ema(_, []), do: 0
  def triple_ema(n, prices) do
    emas = exp_calc(n, prices)
    ema_2s = exp_calc(n, emas |> Enum.reverse)
    ema_3 = exp_calc(n, ema_2s |> Enum.reverse) |> Enum.at(0)
    ema = emas |> Enum.at(0)
    ema_2 = ema_2s |> Enum.at(0)
    %TripleEma{ema: ema, ema_2: ema_2, ema_3: ema_3, value: (3 * ema - 3 * ema_2) + ema_3}
  end
  def triple_ema(n, price, %TripleEma{ema: previous_ema, ema_2: previous_ema_2, ema_3: previous_ema_3}) do
    ema = exp_calc(n, [price], [previous_ema]) |> Enum.at(0)
    ema_2 = exp_calc(n, [ema], [previous_ema_2]) |> Enum.at(0)
    ema_3 = exp_calc(n, [ema_2], [previous_ema_3]) |> Enum.at(0)
    %TripleEma{ema: ema, ema_2: ema_2, ema_3: ema_3, value: (3 * ema - 3 * ema_2) + ema_3}
  end

  @spec weighting_multiplier(integer) :: float
  defp weighting_multiplier(n) do
    2 / (n + 1)
  end 

  @spec exp_calc(integer, [float], [float]) :: [float]
  defp exp_calc(_, [], emas), do: emas 
  defp exp_calc(n, [p | tl], [ema_head | ema_tail]) do
    k = weighting_multiplier(n)
    exp_calc(n, tl, [(p * k) + (ema_head * (1 - k))] ++ [ema_head] ++ ema_tail)
  end
  defp exp_calc(k, [hd | tl]), do: exp_calc(k, tl, [hd])

  @spec weighted([{float, float}]) :: float
  def weighted(items) do
    Enum.reduce(items, 0, fn {a, b} , acc -> acc + (a * b) end)
  end

end