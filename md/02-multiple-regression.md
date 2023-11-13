# Lecture 2: Multiple Regression

## Introduction

The linear model seen in the previous lecture can be extended to multiple variables. This is usefull if we want to predict the price of a house based on more than just one variable, e.g. the size **and** the number of rooms.

Otherwise the model stays the same. This time however we want to fit a hyperplane to the data.

### Multiple Regression Model

$$
y = \beta_0 + \sum_{i=1}^k \beta_i x_i
$$

where $\beta_i$ are the coefficients and $x_i$ are the variables.

### Assumptions of the model

Similarly the model above only works if the data behaves as: $y_i=\beta_0 + \sum_{i=1}^k \beta_i x_i + \epsilon_i$ and $\epsilon_i \sim N(0, \sigma^2)$.

## Least squares introduction

The least squares method can be extended to multiple variables. The only difference is that we now have to find $\hat{\beta}_0, \hat{\beta}_1, \dots, \hat{\beta}_k$ to minimize the sum of squared residuals:

$$
SS_{residual} = \sum_{i=1}^n (y_i - \hat{y}_i)^2
$$

For the calculations to work out nicely we need to define higher dimensional random vectors and matrices.

### Random vectors and matrices

A random vector is a vector whose components are random variables. Similarly a random matrix is a matrix whose components are random variables. For example:

$$
V = \begin{pmatrix} X_1 \\ X_2 \\ \vdots \\ X_n \end{pmatrix} \in \mathbb{R}^n \quad \text{and} \quad M = \begin{pmatrix} X_{11} & X_{12} & \dots & X_{1n} \\ X_{21} & X_{22} & \dots & X_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ X_{m1} & X_{m2} & \dots & X_{mn} \end{pmatrix} \in \mathbb{R}^{m \times n}
$$

#### Expected value

The expected value of such objects is defined as the matrix obtained by taking the expected value of each component. For example:

$$
E(M) = \begin{pmatrix} E(X_{11}) & E(X_{12}) & \dots & E(X_{1n}) \\ E(X_{21}) & E(X_{22}) & \dots & E(X_{2n}) \\ \vdots & \vdots & \ddots & \vdots \\ E(X_{m1}) & E(X_{m2}) & \dots & E(X_{mn}) \end{pmatrix} \in \mathbb{R}^{m \times n}
$$

#### Variance matrix

Calculating the variance is a bit more complicated. Lets start with the variance of a random vector:

$$
V = \begin{pmatrix} X_1 \\ X_2 \\ \vdots \\ X_n \end{pmatrix} \quad \text{with} \quad \mu= E(V) = \begin{pmatrix} \mu_1 \\ \mu_2 \\ \vdots \\ \mu_n \end{pmatrix}
$$

where $\mu$ is the mean of the random vector. The variance matrix is defined as:

$$
\begin{aligned}
\Sigma = Var(V) &= E((V - \mu)(V - \mu)^T) \\
      &= \begin{pmatrix}
        E[(X_1 - \mu_1)^2] & E[(X_1 - \mu_1)(X_2 - \mu_2)] & \dots & E[(X_1 - \mu_1)(X_n - \mu_n)] \\
        E[(X_2 - \mu_2)(X_1 - \mu_1)] & E[(X_2 - \mu_2)^2] & \dots & E[(X_2 - \mu_2)(X_n - \mu_n)] \\
        \vdots & \vdots & \ddots & \vdots \\
        E[(X_n - \mu_n)(X_1 - \mu_1)] & E[(X_n - \mu_n)(X_2 - \mu_2)] & \dots & E[(X_n - \mu_n)^2]
      \end{pmatrix} \\
\end{aligned}
$$

The matrix $\Sigma$ is symmetric and positive semi-definite. The diagonal elements are the variances of the components of $V$ and the off-diagonal elements are the covariances of the components of $V$. If the matrix is diagonal, then the components of $V$ are independent.

#### Properties of random objects

Let $A$ be a constant matrix and $y$ a random vector. Then $Ay$ is also a random vector and:

+ $E(Ay) = AE(y)$
+ $Var(Ay) = AVar(y)A^T$
+ if $y$ is normally distributed, then $Ay$ is also normally distributed

### Least squares model in matrix form

To represent the assumptions of the model in matrix form we can write:

$$
\begin{aligned}
Y &= X\beta + \epsilon \\
\end{aligned}
$$

The matrix $X$ is called the design matrix and is defined as:

$$
X = \begin{pmatrix} 1 & x_{11} & x_{12} & \dots & x_{1k} \\ 1 & x_{21} & x_{22} & \dots & x_{2k} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & x_{n1} & x_{n2} & \dots & x_{nk} \end{pmatrix}
\in \mathbb{R}^{n \times (k+1)} \quad \text{and} \quad \beta = \begin{pmatrix} \beta_0 \\ \beta_1 \\ \vdots \\ \beta_k \end{pmatrix} \in \mathbb{R}^{(k)}
$$

Adding the constant column of $1$'s to the design matrix allows to simplify the notation. The vector $\epsilon$ is defined as:

$$
\epsilon = \begin{pmatrix} \epsilon_1 \\ \epsilon_2 \\ \vdots \\ \epsilon_n \end{pmatrix} \quad \text{with} \quad \epsilon_i \sim N(0, \sigma^2)
$$

To simplify the notation we can write: $\epsilon \sim N(0, \sigma^2 I_n)$ where $I_n$ is the identity matrix of size $n$. The expected value of $\epsilon$ is $E(\epsilon) = 0$ and the variance matrix is $Var(\epsilon) = \sigma^2 I_n$.

### Least squares solution

If we put the least squares model in matrix form we get:

$$
\begin{aligned}
SS_{residual} &= \sum_{i=1}^n (y_i - \hat{y}_i)^2 \\
              &= \sum_{i=1}^n (y_i - \hat{\beta}_0 - \sum_{j=1}^k \hat{\beta}_j x_{ij})^2 \\
              &= (Y - X\hat{\beta})^T (Y - X\hat{\beta}) \\
              &= Y^T Y - Y^T X \hat{\beta} - \hat{\beta}^T X^T Y + \hat{\beta}^T X^T X \hat{\beta} \\
              &= Y^T Y - 2 \hat{\beta}^T X^T Y + \hat{\beta}^T X^T X \hat{\beta} \\
\end{aligned}
$$

To find the minimum we can take the derivative with respect to $\hat{\beta}$ and set it to $0$:

$$
\begin{aligned}
\frac{\partial SS_{residual}}{\partial \hat{\beta}} &= -2 X^T Y + 2 X^T X \hat{\beta} \\
X^T Y &= X^T X \hat{\beta} \\
\hat{\beta} &= (X^T X)^{-1} X^T Y \\
\end{aligned}
$$

This only works if $X^T X$ is invertible. This is the case if the columns of $X$ are linearly independent.

### Hat matrix

Using the multiple regression model we can predict the value of $\hat{y}$ for a new observation $x^*$:

$$
\hat{y} = X \hat{\beta} = \underbrace{X (X^T X)^{-1} X^T}_{H} y = H y
$$

where $H$ is called the hat matrix. $H$ it is a so called projection matrix, i.e. $H$ projects $y$ onto the linear subspace spanned by the columns of $X$.

All projection matrices have the following properties:

+ $H$ is symmetric
+ $H$ is idempotent, i.e. $H^2 = H$

### Residuals

The residuals are defined as:

$$
e = y - \hat{y} = y - H y = (I_n - H) y
$$

$I_n - H$ is also a projection matrix. It projects $y$ onto the linear subspace orthogonal to the linear subspace spanned by the columns of $X$.

Rearranging the equation above we get:

$$
y = \hat{y} + e
$$

This means that the observed value $y$ can bew writen as the sum of the predicted value $\hat{y}$ and the orthogonal residual $e$.
