defmodule Taex.Helpers do

  def high(item) when is_number(item) do
    item
  end
  @doc """
  Gets the highest number in the entire list
  """
  def high(items) when is_list(items) do
    high(items |> Enum.count, items)
  end

  @doc """
  Gets the highest number in the top n items in the list
  """
  def high(n, items) when is_list(items) do
    reversed_items = items |> Enum.reverse |> Enum.take(n)
    calc_high(reversed_items, nil)
  end

  def low(item) when is_number(item) do
    item
  end
  
  def low(items) when is_list(items) do
    low(items |> Enum.count, items)
  end

  def low(n, items) when is_list(items) do
    reversed_items = items |> Enum.reverse |> Enum.take(n)
    calc_low(reversed_items, nil)
  end
  
  defp calc_low(prices, low) do
    case prices do
      [hd | tl] when low == nil -> calc_low(tl, hd)
      [hd | tl] when hd < low -> calc_low(tl, hd)
      [_ | tl] -> calc_low(tl, low)
      _ -> low
    end
  end

  defp calc_high(prices, high) do
    case prices do
      [hd | tl] when high == nil -> calc_high(tl, hd)
      [hd | tl] when hd > high -> calc_high(tl, hd)
      [_ | tl] -> calc_high(tl, high)
      #hd when hd > high -> hd
      _ -> high
    end
  end
end