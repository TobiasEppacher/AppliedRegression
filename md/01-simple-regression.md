# Lecture 1: Simple Regression

## Data

Often in applications we would like to see if there is an association or trend of one variable with another.
For example: How does the price of a house depend on its size?

A dataset for this very simple example would contain only two columns:
- Size of the house (in square meters)
- Price of the house (in €)

A scatter plot of such data can be used to visually interpret the association between the two variables and to get a first impression of the data.
On this data, different models can be fitted to describe the association between the two variables, the simplest of which is a linear model.
Such models can be used to predict the price of a house based on its size.
For linear models we want to fit a line to the data, which is described by the equation

$$
y = \beta_0 + \beta_1 x
$$

## Least squares

The idea is to find $\hat{\beta_0}$ and $\hat{\beta_1}$ that minimizes

$$
\sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2
$$

where $\hat{y}_i = \hat{\beta_0} + \hat{\beta_1} x_i$

This overall minimizes the vertical distances between the data points and the fitted line.

This minimazation problem can be solved by setting the partial derivatives of the sum (w.r.t. $\hat{\beta_0}$ and $\hat{\beta_1}$) to zero and yields the following results:

$$
\begin{aligned}
&\hat{\beta_1} = \frac{\sum_{i=1}^n \left( x_i - \bar{x} \right) \left( y_i - \bar{y} \right)}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} \\
&\hat{\beta_0} = \bar{y} - \hat{\beta_1} \bar{x}
\end{aligned}
$$

## Assumptions

The model $y=\beta_0 + \beta_1 x + \epsilon$ and $\epsilon \sim N(0, \sigma^2)$ requires some assumptions to be valid:

- Independence of $y$
  - Each sample is independent of the others
- Linearity of mean of $y$
  - The mean of $y$ is linearly dependent on $x$
- Homogeneity of variance of $y$
  - The variance of $y$ is constant for all $x$
- Normal distribution of $y$
  - The distribution of $y$ is normal for all $x$

### Estimates for $\beta_0$, $\beta_1$ and $\sigma^2$
Under these conditions it can be shown, that (using the previous formulas) $\hat{\beta_0}$ and $\hat{\beta_1}$ are unbiased estimators for $\beta_0$ and $\beta_1$.

Given an independent set of observations $(x_i, y_i)$ that follow the regression model $y=\beta_0 + \beta_1 x_i + \epsilon_i$ $\epsilon_i \sim N(0, \sigma^2)$, 

$$ 
s^2 = \frac{1}{n-2} \sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2
$$

is an unbiased estimator for $\sigma^2$ which is called the variability.

## Variance of $\hat{\beta_0}$ and $\hat{\beta_1}$

Since $\hat{\beta_0}$ and $\hat{\beta_1}$ are linear combinations of the $y_i$ which are generally normally distributed random variables, they are normally distributed as well. As such their variance can be calculated to be:

$$
\begin{aligned}
&Var(\hat{\beta_0}) = \sigma^2 \left( \frac{1}{n} + \frac{\bar{x}^2}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} \right) \\
&Var(\hat{\beta_1}) = \frac{\sigma^2}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2}
\end{aligned}
$$

$\sigma^2$ can then be substituted by $s^2$ to get the estimated variance of $\hat{\beta_0}$ and $\hat{\beta_1}$.

## T-tests

We want to test for $H_0: \beta_1 = 0$. This hypothesis states that the covariate has no effect on the outcome. 

Under this hypothesis it holds that

$$
T = \frac{\hat{\beta_1}}{\sqrt{var(\hat{\beta_1})}} = \frac{\hat{\beta_1}}{se(\hat{\beta_1})} \sim t_{n-2}
$$

For a given significance level $\alpha$ we can then reject the null hypothesis if $|T| > t_{n-2, 1-\frac{\alpha}{2}}$, where $t_{n-2, 1-\frac{\alpha}{2}}$ is the $1-\frac{\alpha}{2}$ quantile of the $t_{n-2}$ distribution.

Another approach is to calculate the probability of a result as or more extreme than the observed and reject the null hypothesis if $p < \alpha$.
For a two-sided test this probability is given by $2 \cdot (1- P(t < |T|)), t \sim t_{n-2}$.

## Confidence intervals

The confidence interval for $\beta_1$ (with accuracy $1-\alpha$) is given by 

$$
\hat{\beta_1} \pm t_{n-2, 1-\frac{\alpha}{2}} \cdot se(\hat{\beta_1})
$$

Since this is a random function ($\hat{\beta_1}$ is a random variable) the confidence interval is random as well. Hence the interval covers the true value of $\beta_1$ with probability $1-\alpha$.

## Prediction of values

Given a fixed value $x$ we want to predict the value of $y$ at this point. The mean of the distribution of $y$ is given by:

$$
E(y) = E(\beta_0 + \beta_1 x + \epsilon) = E(\beta_0 + \beta_1 x) + E(\epsilon) = \beta_0 + \beta_1 x + 0
$$

We can substitue $\beta_0$ and $\beta_1$ by their estimators $\hat{\beta_0}$ and $\hat{\beta_1}$ to obtain the estimated mean.

$$
\hat{\beta_0} + \hat{\beta_1} x = \bar{y} - \hat{\beta_1} \bar{x} + \hat{\beta_1} x = \bar{y} + \hat{\beta_1} (x - \bar{x})
$$

We assume that $\bar{y}$ is independent of $\hat{\beta_1}$ and can derive that

$$
\begin{aligned}
Var(\hat{\beta_0} + \hat{\beta_1} x) &= Var(\bar{y}) + (x - \bar{x})^2 Var(\hat{\beta_1}) \\
&= \frac{\sigma^2}{n} + (x - \bar{x})^2 \frac{\sigma^2}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} \\
&= \sigma^2 \left( \frac{1}{n} + \frac{(x - \bar{x})^2}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} \right)
\end{aligned}
$$

This is the variance of the distribution of $y$ at $x$. Since the second term increases with the distance of $x$ from $\bar{x}$, the variance increases as well. This means, that the prediction is more uncertain the further away $x$ is from $\bar{x}$.

## Analysis of Variance (ANOVA)

We now want to derive, how much of the variability of $y$ is explained by the model and how much is left unexplained. The total variability is given by

$$
\sum_{i=1}^n \left( y_i - \bar{y} \right)^2
$$

but it can be directly decomposed into the variability due to regression and the residual variability (proof on the slides).

$$
\sum_{i=1}^n \left( y_i - \bar{y} \right)^2 = \sum_{i=1}^n \left( \hat{y}_i - \bar{y} \right)^2 + \sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2
$$

![ANOVA table](images/ANOVA-table.png)

