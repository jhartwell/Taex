defmodule Taex.Points.Macd do
  alias Taex.Indicators

  @type t :: %{value: float}
  defstruct [:value]

  def new(prices), do: new(prices, :standard)
  def new(prices, direction) do
    %Taex.Points.Macd {
      value: Taex.Indicators.macd(prices, direction)
    }
  end
end