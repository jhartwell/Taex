defmodule Taex.AroonPoint do
  @type t :: %{high: float, low: float}
  
  defstruct [:high, :low]
end