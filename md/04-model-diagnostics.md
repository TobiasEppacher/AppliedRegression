# Lecture 4: Model Diagnostics

## Residuals

When the model is correctly specified, the residuals should be identically distributed, according to a normal distribution around the mean 0 and with variance $\sigma^2$.

## Incorrectly Specified Model

If the model is incorrectly specified and missing a vital covariate, the mean of the residuals may not be 0 anymore.

Assumed model: $y=X\beta + \epsilon$

True model: $y=X\beta + U\gamma + \epsilon \quad$ (with $U$ not in the vector space spanned by the columns of $X$)

It follows:

$$
\begin{aligned}
E[\epsilon] &= E[y - \hat{y}] \\
&= (I-H)E[y] \\
&= (I-H)(X\beta + U\gamma) \\
&= (I-H)U\gamma
\end{aligned}
$$

This can't be 0 since $U$ is not in the vector space spanned by the columns of $X$ (which includes 0).

## Distribution of Residuals

We assume $\epsilon$'s to be independent and their variance to be constant.
But this does not hold for the residuals.
$$
    e = y - \hat{y}, \quad Var(e) = \sigma^2(I-H) \\
$$

$$
    Var(e_i) = \sigma^2(1-h_{ii}), \quad Cov(e_i, e_j) = -\sigma^2h_{ij} \quad i \neq j
$$

_($h_{ij}$ are the elements of $H$)_

This means that the residuals cannot be assumed to be independent and don't have constant variance.

## Standardized and Studentized Residuals

It is possible to adjust the residuals to have _approximate_ mean 0 and variance 1. Two methods are the so called standardized and studentized residuals.

Using $s^2 = \frac{e'e}{n-k-1}$ as estimate for $\sigma^2$

Standardized residuals: $e^s_i = \frac{e_i}{s}$

Studentized residuals: $d_i = \frac{e_i}{s\sqrt{1-h_{ii}}}$

## Residual Plots

With normal errors the studentized residuals should approximate a standard normal distribution. This means that absolute values $|d_i| > 2$ or $|d_i| > 3$ are an indicator that the model is probably not correctly specified.

The studentized residuals can help to identify outliers, but outliers can still have a normal studentized residual.

Therefore it is strongly suggested to plot the residuals (or studentized residuals) and look manually for patterns deviating from a normal distribution around 0.

## Serial correlation

In a simple model $y = X\beta + \epsilon$ the errors should be independent.

For samples collected in some time order (e.g. stock prices one day after the other) the residuals may be correlated. The reason for this is, that some event may not only affect one, but multiple successive measurements.

## Autocorrelation of Residuals

$$
    r_k = \frac{\sum_{t=k+1}^{n} e_te_{t-k}}{\sum_{t=1}^{n} e_t^2}, \quad k = 1, 2, \ldots
$$

This is called `lag k autocorrelation` and measures the association between the residuals in the same time series.

$r_0 = 1$ and $-1 \leq r_k \leq 1$ with $E[r_k] \approx 0$ and $Var(r_k) \approx 1/n$ for $k > 0$.

When plotting the autocorrelation, the values $r_k$ for $k>0$ should stay within a band of $\pm 2/\sqrt{n}$. Values outside indicate autocorrelation.

Also plots of $e_t$ vs. $e_{t-k}$ should show no pattern.

## Dubin-Watson Test Statistic

$$
    DW = \frac{\sum_{t=2}^{n} (e_t - e_{t-1})^2}{\sum_{t=1}^{n} e_t^2} \approx 2(1-r_1)
$$

Under the null hypothesis that the residuals are not correlated, this test statistic is approximately $DW \approx 2$. Stronger deviations may indicate dependence between the errors.

Note that this test should only be an informal check. If the data seems to be dependent, alternative time series methods must be used.

## Influence and Leverage of Outliers

Outliers can have a strong influence on the model and should be analysed carefully.

The fitted values $\hat{y}_i$ are weighted averages of its own response and the responses of the other observations.

$$
\hat{y}_i = h_{ii} y_i+ \sum_{j \neq i} h_{ij}y_j \qquad \text{since} (\hat{y} = Hy)
$$

Where $h_{ij}$ are the elements of the hat matrix $H = X(X'X)^{-1}X'$.

Since $Var(e_i) = \sigma^2(1-h_{ii})$, the variance of the residuals
becomes nearly $0$ if $h_{ii}$ is close to 1, such cases have high impact on the fitted line since $e_i=y_i-\hat{y}_i \approx 0$. This is called high leverage since the observation extremely pulls the fitted line towards itself.

### Properties of Leverage

$h_{ii}$ is called the leverage of the $i$-th observation.

- Leverage does not depend on the response $y_i$. It only depends on the covariates $x_i$.
- $\frac{1}{n} \leq h_{ii} \leq 1$
- Leverage is higher for $x$ values far from the mean $\bar{x}$.
- $\sum_{i=1}^{n} h_{ii} = tr[H] = k+1$
- $\bar h = \frac{k+1}{n}$ and a case is called high leverage if $h_{ii} > 2\bar{h}$

High leverage points can have a strong influence on the model, but don't have to.

The influence of an observation is measured by the change in the estimated coefficients if the observation is removed. This measure takes the response $y_i$ into account.

Cook's distance is a measure for the influence of an observation.

$$
    D_i = (\hat\beta - \hat\beta_{(i)})' X'X (\hat\beta - \hat\beta_{(i)}) / [(k+1)s^2]
$$

where $\hat\beta_{(i)}$ is the vector of estimated coefficients without the $i$-th observation.

It can be reformulated as: $D_i = \frac{h_{ii} d^2_i}{(1-h_{ii})(k+1)} \quad$ using $d_i = \frac{e_i}{s\sqrt{1-h_{ii}}}$

All the necessary values can be obtained from a single regression by storing the residuals and the hat matrix.

It also shows that high leverage only has a high influence if the corresponding residual is large as well.

Some general rules for when one should be concerned:

- $D_i > 0.5$ : should be examined
- $D_i > 1$ : great concern
