# Lecture 3: Specification

## One Sample Problem

The one sample problem is used to reason about data that is drawn from a single stable process. The model assumes $y_i = \beta_0 + \epsilon_i$ where $\epsilon_i \sim N(0, \sigma^2)$.

In Matrix from the model is $E[y] = X\beta + \epsilon$ where $X = \begin{bmatrix} 1 & 1 & \cdots & 1 \end{bmatrix}^T$ and $\beta = \begin{bmatrix} \beta_0 \end{bmatrix}$.

This can be solved classicaly using $\hat{\beta} = \bar{y}$ and $s^2 = \frac{1}{n-1} \sum_{i=1}^n (y_i - \bar{y})^2$.

## Two Sample Problem

The two sample problem is used to reason about data that is drawn from two stable processes. For example, we get $m$ observations from one process and $n-m$ observations from another process. Each group has an individual mean. This yields to:

$$
\begin{aligned}
y_i &=
\begin{cases}
\beta_1 + \epsilon_i & \text{for } i = 1, \ldots, m \\
\beta_2 + \epsilon_i & \text{for } i = m+1, \ldots, n
\end{cases}\\
 &= \beta_1 x_{i1} + \beta_2 x_{i2}
\end{aligned}
$$

where $x_{i1} = \begin{cases} 1 & \text{for } i = 1, \ldots, m \\ 0 & \text{for } i = m+1, \ldots, n \end{cases}$ and $x_{i2} = \begin{cases} 0 & \text{for } i = 1, \ldots, m \\ 1 & \text{for } i = m+1, \ldots, n \end{cases}$.

In Matrix form the model is $y = X\beta + \epsilon$ where $X = \begin{bmatrix} 1 & 0 \\ \vdots & \vdots \\ 1 & 0 \\ 0 & 1 \\ \vdots & \vdots \\ 0 & 1 \end{bmatrix}$ and $\beta = \begin{bmatrix} \beta_1 \\ \beta_2 \end{bmatrix}$.

## Interactions

An interaction happens when the effect of one variable affects the effect of another variable. For example, the effect of a drug may be different for different ages.

### Main Effect

If a variable has a main effect, then the effect of the variable is the same for all values of the other variables. For example, the effect of a drug is the same for all ages.

The model for such an interaction is:

$$
y_i = \begin{cases}
\beta_0 + \beta_1 x_i + \epsilon_i & \text{for } i = 1, \ldots, m \\
\beta_0 + \beta_1 x_{i-m} +\beta_2+ \epsilon_i & \text{for } i = m+1, \ldots, n
\end{cases}
$$

where $\beta_2$ is the main effect of the variable. It has a constant effect on all values of the other variable. This model results in two parallel lines if plotted.

The matrix form of the model is $y = X\beta + \epsilon$ where $X = \begin{bmatrix} 1 & x_1 & 0 \\ \vdots & \vdots & \vdots \\ 1 & x_m & 0 \\ 1 & x_1& 1 \\ \vdots & \vdots & \vdots \\ 1 & x_m & 1 \end{bmatrix}$ and $\beta = \begin{bmatrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{bmatrix}$.

### Interaction Effect

If a variable has an interaction effect, then the effect of the variable is different for different values of the other variables. For example, a drug is less effective for older people.

The model for such an interaction is:

$$
y_i = \begin{cases}
\beta_0 + \beta_1 x_i + \epsilon_i & \text{for } i = 1, \ldots, m \\
\beta_0 + \beta_1 x_{i-m} +\beta_2 + \beta_3 x_{i-m} + \epsilon_i & \text{for } i = m+1, \ldots, n
\end{cases}
$$

where $\beta_2$ measures the constant effect of the variable and $\beta_3$ measures the interaction effect of the variable. This model results in two non-parallel lines if plotted.

The matrix form of the model is $y = X\beta + \epsilon$ where $X = \begin{bmatrix} 1 & x_1 & 0 & 0 \\ \vdots & \vdots & \vdots & \vdots \\ 1 & x_m & 0 & 0 \\ 1 & x_1& 1 & x_1 \\ \vdots & \vdots & \vdots & \vdots \\ 1 & x_m & 1 & x_m \end{bmatrix}$ and $\beta = \begin{bmatrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \beta_3 \end{bmatrix}$.

## Multicollinearity

Multicollinearity is when two or more variables are highly correlated. This can cause problems in the model, as one can no longer distinguish between the effects of the individual variables.

Adittionally, multicollinearity can cause the model to be unstable. As the matrix $X^TX$ becomes more and more singular, the variance of the estimates increases.

## Orthogonal Design

For many models, the design matrix $X$ can be made orthogonal. This means that the matrix $X$ is chosen such that all columns are orthogonal to each other.

This has the advantage that all regression coefficients remain the same, even if the model is extended. This is because the columns of $X$ are linearly independent.

Additionally it is very easy to compute the regression coefficients.
