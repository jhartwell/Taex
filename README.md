# DISCLAIMER

I am no longer maintaining this project. I will answer any questions to the best of my ability but cannot guarantee a useful or timely answer.

# Taex

Taex is a library to provide easy access to many of the technical analysis calculations done while trading on open markets (stock, forex, etc). 

In order to use this library you can add

For the latest version (which could be broken), you can pull from GitHub:

`{:taex, git: "https://github.com/jhartwell/Taex.git"}`

If you want the stable version, then pull from hex by adding:

`{:taex, "~> 0.1.2"}`

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


