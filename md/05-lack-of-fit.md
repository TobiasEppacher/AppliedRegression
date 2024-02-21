# Lecture 5: Lack of Fit

## Lack of Fit Tests

Dataset: $n$ observations, $k<n$ different values of $x$ observed (for simplicity only one covariate $x$).

- Test the fit of a linear relationship model: $y = \beta_0 + \beta_1x + \epsilon$.

- A lack of fit test requires multiple observations for each $x$ value: $n_1, \dots, n_k$.

- Example: Yield of a chemical process repeated several times on each of 6 different temperatures.

Such experiments can be modeled using classification (each $x$ value is a class with its own effect):
$$
    y_{ij} = \beta_1I(x_i = x_1) + \dots + \beta_kI(x_i = x_k) + \epsilon_{ij}, \quad \epsilon_{ij} \sim N(0, \sigma^2)
$$

It holds that:
$$
    (\hat{\beta}_1, \dots, \hat{\beta}_k) = (\bar{y}_1, \dots, \bar{y}_k) \\
    SS_{residual} = \sum_{i=1}^{k} \sum_{j=1}^{n_i} (y_{ij} - \bar{y}_i)^2 \\
    df: n-k
$$

Meaning each $\hat{\beta}_i$ is the mean of the $y$ values of the $i$-th class and the residual sum of squares is the sum of all sum of squares from each individual class and has $n-k$ degrees of freedom.

### Construction of the Test

Consider our restricted model we want to test for: $y_{ij} = \beta_0 + \beta_1x_i + \epsilon_{ij}$.

$$
\begin{aligned}
    SS^{restricted}_{residual} &= \sum_{i=1}^{k} \sum_{j=1}^{n_i} (y_{ij} - \hat{\beta}_0 - \hat{\beta}_1x_i)^2 \\
    &= SS^{full}_{residual} - SS^{lackoffit}_{residuals} \\
    &= PESS - LFSS
\end{aligned} \\
LFSS = \sum_{i=1}^{k} n_i (\bar{y}_i - \hat{\beta}_0 - \hat{\beta}_1x_i)^2
$$

The lack of fit sum of squares is the difference between the residual sum of squares of the full model and the restricted model, with $SS^{restricted}_{residual} \geq SS^{full}_{residual}$ and $LFSS \geq 0$.

### Testing for lack of fit

Restricted Hypothesis: $H_{restricted}: \mu_{restrict} = \beta_0 + \beta_1x_i$.

vs.

Full Hypothesis: $H_{full}: \mu_{full} = \beta_1I(x_i=x_1) + \dots + \beta_kI(x_i=x_k)$.

$$
    F=\frac{SS^{restricted}_{residual} - SS^{full}_{residual} / (k-2)}{SS^{full}_{residual} / (n-k)} = \frac{LFSS / (k-2)}{PESS / (n-k)} \sim F_{k-2, n-k}
$$

Using the resulting value, arbitrary significance levels can be used to test the hypothesis.

## Variance Stabilizing Transformations

Typically the variance of the data tends to increase with the mean. This is bad for linear models since the residuals are assumed to be normally distributed with constant variance.

Assume the error $\epsilon \sim N(0, [h(\mu)]^2 \sigma^2)$, where $h(\mu)$ is a function of the mean. The goal is to find a transformation $g(y)$ such that the variance of the transformed data is constant with respect to the mean. This can be achieved by using a function where $g'(\mu) = \frac{1}{h(\mu)}$.

**Example:** $h(\mu) = \mu$ (variance increases with the mean)

- $g(\mu) = \log(\mu)$
- This means that the regression target $y$ should be transformed to $\log(y)$ before fitting the model. After the model is fitted, the predictions can be transformed back to the original scale using the inverse transformation $g^{-1}(y) = e^y$.
- By using this transformation, the residuals will have constant variance with respect to the mean during the fitting process.

### Box-Cox Transformations

The box-cox transformation is a family of power transformations. It tries to find the best power transformation $\lambda$ such that the variance of the transformed data is constant with respect to the mean.

- Find $\lambda$ such that $y^{(\lambda)}_i = \frac{y_i^\lambda - 1}{\lambda \bar{y}^{\lambda - 1}_g}$ minimizes the residual sum of squares $SS_{residual}(\lambda)$.
- $\bar{y}_g = [\prod_{i=1}^{n} y_i]^{1/n}$ is the geometric mean of $y$ for the sample used to fit the model.
- After $\lambda$ is selected, just the power $\lambda$ is applied to the $y$, the other things are dropped.

Most commonly $SS_{residual}(\lambda)$ is computed for some grid values and the best one selected:

- $\lambda = 0$: log transform
- $\lambda = 0.5$: square root transform
- $\lambda = 1$: no transform
- $\lambda = 2$: square transform
