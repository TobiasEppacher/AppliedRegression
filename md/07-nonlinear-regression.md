# Lecture 7: Nonlinear Regression

So far we have only considered linear models of the form $y = \beta_0 + \beta_1x_1 + \dots + \beta_px_p + \epsilon$. However we also want to consider models where $E[Y|X]$ is not linear in $X$.

## Transformations

Sometimes it is possible to transform the covariates or the response variable to make the relationship linear. For example, if the relationship is:

$$
y = a x_1^{\beta_1} x_2^{\beta_2} \epsilon
$$

Which has multiplicative error $\epsilon$ with $\epsilon_t=log(\epsilon) \sim N(0, \sigma^2)$, then we can take the logarithm of both sides to get:

$$
\begin{aligned}
    \underbrace{log(y)}_{Y} &= \underbrace{log(a)}_{\beta_0} + \beta_1 \underbrace{log(x_1)}_{X_1} + \beta_2 \underbrace{log(x_2)}_{X_2} + \underbrace{log(\epsilon)}_{\epsilon_t} \\
    Y &= \beta_0 + \beta_1X_1 + \beta_2X_2 + \epsilon_t
\end{aligned}
$$

We can then use the linear model to estimate the parameters $\beta_0, \beta_1, \beta_2$. To get the original parameters, we can exponentiate the estimated parameters. $\hat{a} = exp(\hat{\beta}_0)$, $\hat{\beta}_1 = \beta_1$, $\hat{\beta}_2 = \beta_2$.

## Trend Models with infinite growth

The parameter $\gamma$ is the growth rate of the trend. All of these models have the property that the mean of the response variable grows without bound as $t$ increases.

### Linear Trend model

$$
\mu_t = a + \gamma t
$$

### Exponential model

$$
\mu_t = \beta e^{\gamma t}
$$

## Trend Models with Asymptotic Behavior

These models have the property that the mean approaches a limit as $t$ increases.

### Modified Exponential Model

$$
\mu_t = a - \beta e^{-\gamma t}
$$

This model starts at $a-\beta$ and approaches $a$ as $t$ increases.

### Logistic Model

$$
\mu_t = \frac{a}{1+\beta e^{-\gamma t}}
$$

This model starts at $\frac{a}{1+\beta}$ and approaches $a$ as $t$ increases.

## Newton Raphson Method

Since the models are nonlinear, we can't use the normal equations to solve for the parameters. Instead we use the Newton-Raphson method to find the MLE.

In particular we want to minimize the negative log-likelihood which is the error function:

$$
f(\beta)=E(\beta) = -\sum_{i=1}^{n} \left[ y_i - \mu(x_i, \beta) \right]^2 \\
$$

The Newton-Raphson method is an iterative method to find the minimum of a function. It uses the **second derivative** of the function to find the minimum. Therefore it only works if the function is twice differentiable.

The update step is given by:

$$
\beta^{(k+1)} = \beta^{(k)} - \left[ H(\beta^{(k)}) \right]^{-1} \nabla f(\beta^{(k)})
$$

Where $H(\beta^{(k)})$ is the Hessian matrix of the error function and $\nabla f(\beta^{(k)})$ is the gradient of the error function.

This is repeated until convergence.
