# Lecture 8: Time Series

Time series models are used to model the dependence between observations in time. The main goal is to forecast future values of the time series. Its assumed that all data points are equally spaced in time.

## First Order Autoregressive Model

The first order autoregressive model (AR(1)) is defined as:

$$
y_t = \mu(X_t, \beta) + \epsilon_t \\
\epsilon_t = \phi \epsilon_{t-1} + a_t
$$

where $\mu(X_t, \beta)$ is the mean of the time series, $\epsilon_t$ is the error term at time $t$, $\phi$ is the autoregressive parameter and $a_t \sim N(0, \sigma^2)$ is the white noise term.

Since the errors depend on the previous data its a first order autoregressive model. The mean of the time series can be a linear function of covariates or a constant.

The mean of the AR(1) model is:

$$
E[\epsilon_t] = 0
$$

The variance of the AR(1) model is:

$$
Var(\epsilon_t) = \sigma^2 [1 + \phi^2 + \phi^4 + \ldots] = \frac{\sigma^2}{1 - \phi^2}
$$

> **Note** TO DO: finish this chapter
