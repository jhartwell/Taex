# DISCLAIMER

  Do note that this library is maintained to the best of its ability and all bugs will be addressed as soon as possible. That said, there is risk when using this library as formulas may be incorrect. By using this library
  you are acknowleding that the maintainers will not be liable for any issues that may arise from using the library while trading (such as any losses due to bugs)

# Taex

Taex is a library to provide easy access to many of the technical analysis calculations done while trading on open markets (stock, forex, etc). 

In order to use this library you can add

For the latest version (which could be broken), you can pull from GitHub:

`{:taex, git: "https://github.com/jhartwell/Taex.git"}`

If you want the stable version, then pull from hex by adding:

`{:taex, "~> 0.1.0"}`

to your deps in the mix.exs file

# Dependencies

Taex is dependents on the elixir statistics library https://github.com/msharp/elixir-statistics

# Features

Currently supported features:

  * Moving Average
    * Exponential
    * Simple
    * Weighted

  * Indicators
    * MACD (Moving Average Convergence Divergence)
    * Aroon

  * Oscillators
    * Stochastic
    * Bollinger Bands


