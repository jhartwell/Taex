defmodule Taex.Oscillators do
  alias Taex.MovingAverage
  alias Statistics

  
  @doc """
  Calculates the stochastic current market rate for the given list of prices (%K)
  """
  @spec stochastic([float]) :: float
  def stochastic(prices) when is_list(prices) do
    c = Enum.at(prices, (prices |> Enum.count) - 1)
    l14 = Taex.Helpers.low(14, prices)
    h14 = Taex.Helpers.high(14, prices)
    100 * (c - l14)/(h14 - l14)
  end

  @doc """
  Calculates the 3 day moving average of stocastic current market rates (%D)
  """
  @spec stocastic_ma([float]) :: float
  def stocastic_ma(stochastics) when is_list(stochastics) do
    MovingAverage.simple(3, stochastics)
  end

  
end