defmodule Taex.Points.Aroon do
  alias Taex.Indicators
  @type t :: %{high: float, low: float}
  
  defstruct [:high, :low]

  def new(prices) when is_list(prices) do
    %Taex.Points.Aroon {
      high: Indicators.aroon_up(prices),
      low: Indicators.aroon_down(prices)
    }
  end
end