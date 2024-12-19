# ForecastingScores.jl
> Note: This Module is under development, use it at your own risk!

> Evaluate the performance of your prediction models using strictly proper scoring functions.

All useful models make predictions. Assessing the quality of these predictions is essential to understanding a model's limits, how to use it responsibly and how it compares to alternative models.  

A forecasting score quantifies how accuratly a series of events were predicted to occur. The Brier and logistic scoring algorithms are _strictly proper scoring functions_ which are optimal when the predicted probability of an event occuring matches the true probability. 

This package provides three scoring algorithms, `brier_score`, `logistic_score` and `naive_score`, to rate your predictions with. 

## Installation

1. Clone this repository to your local drive
2. Enter the `julia` REPL in the repository's parent directory
3. run `Pkg.add(ForecastingScores)` to add the module to your environment

**NOTE this package has not been developed to the exact Pkg guidelines and should not be installed globally.**

## Usage

To create a set of predictions about some events and whether or not they occurred, create a `EventRecord`.

```julia
> eventrecord = Dict(
  0.5 => true,
  0.1 => false,
  0.99 => true
) |> EventRecord;
> brier_score(eventrecord)
0.08669999241828918
```

## Types of scores

Brier score (`brier_score`) - A quadratic distance between the truth value of an event, $o_i$, and its predicted probability, $p_i$. A low Brier score means a series of predictions closely matches what actually occured, but makes less meaningful inferences from predicting rare events accurately. 

$$\text{Brier Score} = \frac{1}{N} \sum_{i=1}^{N} (p_i - o_i)^2$$  

Logarithmic score (`logarithmic_score`) - The expectation value of the logarithmic score is largest when the predicted probability is the same as the true probability of the event occuring. It handles extreme predictions far better than the Brier score, but is unbounded and harder to interpret without comparing it to other logarithmic scores.

$$\text{Logarithmic score} = \frac{1}{N} \sum_{i=1}^{N} f(o_i, p_i) \quad \text{where} \quad f(o_i, p_i) = \begin{cases} \log(p_i) & : o_i = 1 \\ \log(1 - p_i) & : o_i = 0 \end{cases} $$

Naive score (`naive_score`) - A simple scoring algorithm that calculates the difference between prediction and outcome. This is not a strictly proper score as it has a bias towards extreme predictions; it is included to compare against other methods.

$$ \text{Naive score} = \frac{1}{N} \sum_{i=1}^{N} |p_i - o_i| $$

## Credit
_Ben Butterworth, 2024_
