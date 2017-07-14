defmodule Taex.MovingAverage do
  @spec simple(integer, [float]) :: float
  def simple(n, items \\ []) do
    sum = items |> Enum.reverse |> Enum.take(n) |> Enum.sum
    sum / n
  end

  def exponential(n, prices) when is_list(prices) do
    [hd] = exponential_list(n, prices) |> Enum.reverse |> Enum.take 1
    hd
  end

  def exponential(n, prices) do
    [hd] = exponential_list(n, [prices]) |> Enum.reverse |> Enum.take 1
    hd
  end
  def exponential_list(n, prices) when is_list prices do
    count = prices |> Enum.count
    k = 2 / (n + 1)
    case n do
      i when i < count -> prices |> Enum.drop(count - n) |> exp(k, [])
      _ -> {:error, "EMA period is more than prices that were provided"}
    end
  end

  defp exp(prices, k,  ema) do
    case ema do
      [hd | tl] -> case prices do
                    [p | t] -> t |> exp(k, ema ++ [(p * k) + (hd * (1 - k))])
                    [p] -> ema ++ [(p * k) + (hd * (1 - k))]
                    [] -> ema
                  end
      [hd] ->  case prices do
                    [p | t] -> t |> exp(k, (ema ++ [(p * k) + (hd * (1 - k))]))
                    [p] -> ema ++ [(p * k) + (hd * (1 - k))]
                    [] -> ema
               end
      [] -> case prices do
              [p | t] -> t |> exp(k, [p])
              [p] -> [p]
               [] -> []
            end
      end
  end
end