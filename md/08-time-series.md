# Lecture 8: Time Series

Time series models are used to model the dependence between observations in time. The main goal is to forecast future values of the time series. Its assumed that all data points are equally spaced in time.

## First Order Autoregressive Model

The first order autoregressive model (AR(1)) is defined as:

$$
y_t = \mu(X_t, \beta) + \epsilon_t \\
\epsilon_t = \phi \epsilon_{t-1} + a_t
$$

where $\mu(X_t, \beta)$ is the mean of the time series, $\epsilon_t$ is the error term at time $t$, $\phi$ is the autoregressive parameter and $a_t \sim N(0, \sigma^2)$ is the white noise term.

Since the errors depend on the previous data its a first order autoregressive model.

By recursively substituting the error term we get:

$$
\epsilon_t = a_t + \phi a_{t-1} + \phi^2 a_{t-2} + \ldots + \phi^{t-1} a_1
$$

### Mean

The mean of the error term is 0:

$$
E[\epsilon_t] = E[a_t + \phi a_{t-1} + \phi^2 a_{t-2} + \ldots + \phi^{t-1} a_1] = 0
$$

since all $a_t$ have mean 0.

### Variance

The variance of the error term is:

$$
Var(\epsilon_t) = Var(a_t + \phi a_{t-1} + \phi^2 a_{t-2} + \ldots + \phi^{t-1} a_1) = \sigma^2 [1 + \phi^2 + \phi^4 + \ldots] = \frac{\sigma^2}{1 - \phi^2}
$$

since the $a_t$ are independent and have variance $\sigma^2$.

### Covariance

The covariance of the error term is:

$$
\begin{aligned}
Cov(\epsilon_t, \epsilon_{t-k}) &= E[\epsilon_t \epsilon_{t-k}] - E[\epsilon_t]E[\epsilon_{t-k}] \\
&= E[\epsilon_t \epsilon_{t-k}] \quad \text{(since $E[\epsilon_t] = 0$)} \\
&= E[(a_t + \phi \epsilon_{t-1}) \epsilon_{t-k}] \\
&= E[a_t \epsilon_{t-k}] + \phi E[\epsilon_{t-1} \epsilon_{t-k}] \\
&= 0 + \phi E(\epsilon_{t-1}, \epsilon_{t-k}) \quad \text{(since $E[a_t \epsilon_{t-k}] =E[a_t]E[\epsilon_{t-k}] = 0$)} \\
&= \phi Cov(\epsilon_{t-1}, \epsilon_{t-k})
\end{aligned}
$$

### Correlation

The correlation of the error term is:

$$
\begin{aligned}
Cor(\epsilon_t, \epsilon_{t-k}) &= \frac{Cov(\epsilon_t, \epsilon_{t-k})}{\sqrt{Var(\epsilon_t)Var(\epsilon_{t-k})}} \\
&= \frac{\phi Cov(\epsilon_{t-1}, \epsilon_{t-k})}{\sqrt{Var(\epsilon_t)Var(\epsilon_{t-k})}} \\
&\approx \frac{\phi Cor(\epsilon_{t-1}, \epsilon_{t-k})}{\sqrt{\sigma^2 / (1 - \phi^2) \cdot \sigma^2 / (1 - \phi^2)}} \\
&\approx \phi Cor(\epsilon_{t-1}, \epsilon_{t-k})
\end{aligned}
$$

### Autocorrelation Function

The lag $k$ autocorrelation function is defined as:

$$
\begin{aligned}
r_k &= Cor(\epsilon_t, \epsilon_{t-k}) \\
&= \frac{Cov(\epsilon_t, \epsilon_{t-k})}{\sqrt{Var(\epsilon_t)Var(\epsilon_{t-k})}} \\
&\approx \phi Cor(\epsilon_{t-1}, \epsilon_{t-k}) \\
&\approx \phi^2 Cor(\epsilon_{t-2}, \epsilon_{t-k}) \\
&\approx \ldots \\
&\approx \phi^k Cor(\epsilon_{t-k}, \epsilon_{t-k}) \\
&\approx \phi^k
\end{aligned}
$$

This means that the autocorrelation function of an AR(1) model is a geometric sequence with common ratio $\phi$. It vanishes as $k$ increases.

The covariance matrix of the error term $\epsilon$ is:

$$
\Sigma = Var(\epsilon)
\begin{bmatrix}
1 & \phi & \phi^2 & \phi^3 & \ldots & \phi^{n-1} \\
\phi & 1 & \phi & \phi^2 & \ldots & \phi^{n-2} \\
\phi^2 & \phi & 1 & \phi & \ldots & \phi^{n-3} \\
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots \\
\phi^{n-1} & \phi^{n-2} & \phi^{n-3} & \phi^{n-4} & \ldots & 1
\end{bmatrix}
$$

where $Var(\epsilon) \approx \sigma^2 / (1 - \phi^2)$.

This means that the resulting model becomes: $y = X\beta + \epsilon$ where $\epsilon \sim N(0, \Sigma)$.

## Random Walk Model

The random walk model is a special case of the AR(1) model with $\phi = 1$:

$$
y_t = \mu(X_t, \beta) + \epsilon_t \\
\epsilon_t =  \epsilon_{t-1} + a_t
$$

where $\mu(X_t, \beta)$ is the mean of the time series, $\epsilon_t$ is the error term at time $t$ and $a_t \sim N(0, \sigma^2)$ is the white noise term.

The difference is that the random walk model accumulates the errors over time without any decay.

The analysis of the random walk model is similar to the [AR(1) model](#first-order-autoregressive-model).

## Second Order Autoregressive Model

The second order autoregressive model (AR(2)) is defined as:

$$
y_t = \mu(X_t, \beta) + \epsilon_t \\
\epsilon_t = \phi_1 \epsilon_{t-1} + \phi_2 \epsilon_{t-2} + a_t
$$

where $\mu(X_t, \beta)$ is the mean of the time series, $\epsilon_t$ is the error term at time $t$, $\phi_1$ and $\phi_2$ are the autoregressive parameters and $a_t \sim N(0, \sigma^2)$ is the white noise term.

It is valid if the following conditions are met:

- $\phi_1 + \phi_2 < 1$
- $\phi_1 - \phi_2 < 1$
- $-1 < \phi_2 < 1$

The expected value of the error term is 0. And the first lag autocorrelation function is: $r_1 = \frac{\phi_1}{1 - \phi_2}$. The remaining analysis is ommited.

## Moving Average Model / Noisy random walk

The moving average model is defined as:

$$
y_t = \mu(X_t, \beta) + \epsilon_t \\
\epsilon_t = [1-\theta](a_{t-1} + a_{t-2} + \ldots) + a_t
$$

where $\mu(X_t, \beta)$ is the mean of the time series, $\epsilon_t$ is the error term at time $t$, $\theta$ is the moving average parameter and $a_t \sim N(0, \sigma^2)$ is the white noise term.

This model takes a weighted average of the previous errors and adds a new error term. The expected value of the error term is 0.

The name comes from the fact that the model is a random walk combined with a moving average of the previous errors.

$$  
\epsilon_t = \underbrace{a_t + \epsilon_{t-1}}_{\text{random walk}} - \underbrace{\theta \epsilon_{t-1}}_{\text{fraction of previous errors}}
$$

Another expression for the error term is:

$$
\epsilon_t = (1-\theta) [\epsilon_{t-1} + \theta \epsilon_{t-2} + \theta^2 \epsilon_{t-3} + \ldots] + a_t
$$

which means that the error term is a weighted average of **all** the previous errors.

## Forecasting

The goal of all time series models is to forecast future values of the time series. By calculating $y_{t+1}$ we can forecast the next value of the time series.

### AR(1) Forecast

The forecast of the AR(1) with a single covariate is:

$$
\hat{y}_{t+1} = \hat\phi y_t (1 - \hat\phi)\hat\beta_0 (x_{t+1} - \hat\phi x_t)\hat\beta_1
$$

The confidence interval for the forecast is:

$$
\hat{y}_{t+1} \pm t_{\alpha/2, n-2} \sqrt{Var(\hat{y}_{t+1})}
$$

where $t_{\alpha/2, n-2}$ is the $1-\alpha/2$ quantile of the t-distribution with $n-2$ degrees of freedom.

By recursively calculating the forecast we can forecast the next $k$ values of the time series.

$$
\hat{y}_{t+r} = \hat\phi \hat{y}_{t+r-1} + (1-\hat\phi)\hat\beta_0 + (x_{t+r} - \hat\phi x_{t+r-1})\hat\beta_1
$$

### Random Walk Forecast

The forecast of the random walk model is:

$$
\hat{y}_{t+1} = y_t + \hat\beta_1(x_{t+1} - x_t) - \hat\theta a_t
$$

One can also predict the optimal $a_t$ by minimizing the mean squared error of the forecast. This is needed when the white noise term is not known.
