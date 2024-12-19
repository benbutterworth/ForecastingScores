# Forecast Scores
> Note: This Module is under development, use it at your own risk!

> A module to evaluate the prediction performance of your models.

All models generate predictions. Evaluating the quality of a model's predictions is essential to understanding its limits and using it responsibly. 

A forecasting score assigns a numerical value to a set of predictions that can be used to measure their accuracy. The Brier and Logistic scoring algorithms are _strictly proper scoring functions_ that are optimal when the prediction is exactly correct. 

This package provides three scoring algorithms, `brier_score`, `logistic_score`, `naive_score`, and `EventRecord`, a structure to track predictions and their outcomes. 

## Types of scores

Brier score (`brier_score`) - A quadratic distance between the truth value of an event and it's predicted probability
```
$$
\text{Brier Score} = \sum_i (p_i - o_i)^2
$$  
```
Logistic score (`logistic_score`) - An score that is largest when the prediction is exactly the true probability.
```
$$  
\text{Logistic score} = \sum_i f(o_i, p_i) \quad \text{where} \quad f(o_i, p_i) = \begin{cases}
\log(p_i) & \text{if } o_i = 1 \\
\log(1 - p_i) & \text{if } o_i = 0
\end{cases}
$$
```
