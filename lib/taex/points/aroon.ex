defmodule Taex.Points.Aroon do
  @type t :: %{high: float, low: float}
  
  defstruct [:high, :low]
end