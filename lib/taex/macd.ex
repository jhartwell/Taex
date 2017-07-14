defmodule Taex.Macd do
  @type t :: %{line: float, signal: float, histogram: float}
  defstruct [:line, :signal, :histogram]
end