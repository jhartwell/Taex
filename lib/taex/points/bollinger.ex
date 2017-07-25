defmodule Taex.Points.Bollinger do
  defstruct [:upper, :middle, :lower]

  alias Taex.Oscillators

  def new(prices) do
    %Taex.Points.Bollinger {
      upper: Taex.Oscillators.bollinger_band(prices, fn x, y -> x + y end),
      middle: Taex.Oscillators.bollinger_middle_band(prices),
      lower: Taex.Oscillators.bollinger_band(prices, fn x, y -> x - y end)
    }
  end
end