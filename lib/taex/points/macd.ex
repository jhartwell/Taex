defmodule Taex.Points.Macd do
  alias Taex.Indicators

  @type t :: %{value: float}
  defstruct [:value]

  def new(prices) do
    %Taex.Points.Macd {
      value: Taex.Indicators.macd(prices)
    }
  end
end