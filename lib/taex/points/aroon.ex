defmodule Taex.Points.Aroon do
  alias Taex.Indicators
  @type t :: %{high: float, low: float}
  
  defstruct [:high, :low]

  def new(prices), do: new(prices, :standard)
  def new(prices, direction) do
    %Taex.Points.Aroon {
      high: Indicators.aroon_up(prices, direction),
      low: Indicators.aroon_down(prices, direction)
    }
  end
end