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

where $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i$

This overall minimizes the vertical distances between the data points and the fitted line.

This minimazation problem can be solved by setting the partial derivatives of the sum (w.r.t. $\hat{\beta_0}$ and $\hat{\beta_1}$) to zero and yields the following results:

$$
\begin{aligned}
&\hat{\beta_1} = \frac{\sum_{i=1}^n \left( x_i - \bar{x} \right) \left( y_i - \bar{y} \right)}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} = \frac{S_{xy}}{S_{xx}}\\
&\hat{\beta_0} = \bar{y} - \hat{\beta_1} \bar{x}
\end{aligned}
$$

The equation for $\hat{\beta_1}$ states that the fitted line always goes through the point $(\bar{x}, \bar{y})$ and that the slope is given by the ratio of the covariance of $x$ and $y$ and the variance of $x$.

The abreveations $S_{ab}$ denotes the sum of the products of the deviations of $a$ and $b$ from their means. It can be calculated as follows:

$$
S_{ab} = \sum_{i=1}^n \left( a_i - \bar{a} \right) \left( b_i - \bar{b} \right)
$$

The formula for $\hat{\beta_1}$ can also be written as:

$$
\hat{\beta_1} = \frac{\sum_{i=1}^n \left( x_i - \bar{x} \right) y_i}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2} = \sum_{i=1}^n c_i y_i
$$

where $c_i = \frac{x_i - \bar{x}}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2}$.

## Assumptions

The model $y=\beta_0 + \beta_1 x + \epsilon$ and $\epsilon \sim N(0, \sigma^2)$ requires some assumptions to be valid:

- Independence of $y$
  - Each sample is independent of the others
  - (E.g. daily temperatures are not independent, since they tend to be similar to the previous day)
- Linearity of mean of $y$
  - The mean of $y$ is linearly dependent on $x$
  - (This allows the fitted line to pass through the center of the data)
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

is an unbiased estimator for $\sigma^2 = Var(\epsilon_i)$. This is called the residual variance, and measures the variance around the fitted line.

The denominator $n-2$ is called the degrees of freedom and is the number of independent observations minus the number of parameters estimated (at least in this model).

Calculating $\hat{\beta_0}$ and $\hat{\beta_1}$ requires 2 data points (since we want to fit a line), so whenever we are using the already estimated $\hat{\beta_0}$ and $\hat{\beta_1}$ we have $n-2$ free points left.

In this case we estimate the two parameters $\beta_0$ and $\beta_1$ (which are hidden in $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i$) and therefore have $n-2$ degrees of freedom.

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

We want to test for $H_0: \beta_1 = 0$. This hypothesis states that the covariate has no effect on the outcome. Meaning that there is absolutely no association between the two variables.

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
\sum_{i=1}^n \left( y_i - \bar{y} \right)^2 =\underbrace{ \sum_{i=1}^n \left( \hat{y}_i - \bar{y} \right)^2}_{
\text{explained by regression}} + \underbrace{\sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2}_{ \text{residual variability}}
$$

![ANOVA table](images/ANOVA-table.png)

## Percentage of variability explained

The percentage of variability explained by the model is given by the ratio of the variability explained by the model and the total variability.

$$
R^2 = \frac{\sum_{i=1}^n \left( \hat{y}_i - \bar{y} \right)^2}{\sum_{i=1}^n \left( y_i - \bar{y} \right)^2} = \frac{SS_{reg}}{SS_{tot}}
$$

where $SS_{reg}$ is the sum of squares explained by the regression and $SS_{tot}$ is the total sum of squares. The result is a number between 0 and 1 which describes how many percent of the variability is explained by the model.

## Pearson's correlation coefficient

Another measure of the association between two variables is Pearson's correlation coefficient. It is defined as:

$$
r = sgn(\beta_1) \sqrt{R^2}
$$

where $sgn(\cdot)$ is the sign function. The pearson correlation coefficient is always between -1 and 1 and describes the strength of the linear association between the two variables. It is symmetric, meaning that $r(x, y) = r(y, x)$, so it does not matter which variable is the covariate and which is the outcome.
