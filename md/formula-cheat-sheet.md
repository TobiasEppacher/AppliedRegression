# Formulas Cheat Sheet

## Simple regression

### Probability

Let $X, Y$ be random variables and $a, b$ constants.

#### Expected value

+ Expected value of a constant
  + $E(a) = a$
  
+ Linearity of expectation
  + $E(aX + bY) = aE(X) + bE(Y)$

+ Sample mean
  + $\bar{x} = \frac{1}{n} \sum_{i=1}^n x_i$

#### Variance

+ Variance of a constant
  + $Var(X) = E[(X - \mu)^2] = E(X^2) - E(X)^2$

+ Variance of an additive constant
  + $Var(aX+b) = a^2 Var(X)$
  
+ Variance of a linear combination
  + $Var(aX + bY) = a^2 Var(X) + 2ab Cov(X, Y) + b^2 Var(Y)$

+ Sample variance
  + $var_x = \frac{1}{n-1} S_{xx} = \frac{1}{n-1} \sum_{i=1}^n (x_i - \bar{x})^2$

#### Standard error

+ Standard error of a random variable
  + $sd(X) = \sqrt{Var(X)}$

#### Analysis of variation

+ Total sum of squares
  + $SS_{total} = \sum_{i=1}^n (y_i - \bar{y})^2$
  + $SS_{regression} = \sum_{i=1}^n (\hat{y}_i - \bar{y})^2$
  + $SS_{residual} = \sum_{i=1}^n (y_i - \hat{y}_i)^2$
  + $SS_{total} = SS_{regression} + SS_{residual}$

#### Covariance

+ Definition
  + $Cov(X, Y) = E[(X - \mu_X)(Y - \mu_Y)] = E(XY) - E(X)E(Y)$
    + $Cov(X, X) = Var(X)$
  + The covariance is $0$ if $X$ and $Y$ are independent

+ Covariance of $X$ and a constant
  + $Cov(X, a) = 0$

+ Covariance under constant multiplication
  + $Cov(aX, bY) = ab Cov(X, Y)$

+ Covariance under addition
  + $Cov(X +a, Y + b) = Cov(X, Y)$

+ Symmetry
  + $Cov(X, Y) = Cov(Y, X)$

+ Linearity of covariance (in each argument)
  + $Cov(aX + bY, Z) = aCov(X, Z) + bCov(Y, Z)$
    + $Cov(\sum_{i=1}^n a_i X_i, Y) = \sum_{i=1}^n a_i Cov(X_i, Y)$

+ Sample covariance
  + $cov_{xy} = \frac{1}{n-1} S_{xy} = \frac{1}{n-1} \sum_{i=1}^n (x_i - \bar{x})(y_i - \bar{y})$

#### Correlation

+ Definition
  + $cor(X, Y) = \frac{Cov(X, Y)}{sd(X) sd(Y)} = \frac{Cov(X, Y)}{\sqrt{Var(X) Var(Y)}}$

## Multiple regression

### Probability of vectors and matrices

Let $\mathbf{X}, \mathbf{Y}$ be random vectors and $\mathbf{A}, \mathbf{B}$ be matrices.

#### Expected value of a vector or matrix

+ Expected value of a vector
  + $E[\mathbf{X}] = \begin{bmatrix} E[X_1] \\ E[X_2] \\ \vdots \\ E[X_n] \end{bmatrix}$

+ Linearity of expectation
  + $E[\mathbf{A}\mathbf{X} + \mathbf{B}\mathbf{Y}] = \mathbf{A}E[\mathbf{X}] + \mathbf{B}E[\mathbf{Y}]$

#### Variance of a vector or matrix

+ Variance matrix

  + $Var(\mathbf{X}) = E[(\mathbf{X} - \mathbf{\mu})(\mathbf{X} - \mathbf{\mu})^T] = E[\mathbf{X}\mathbf{X}^T] - E[\mathbf{X}]E[\mathbf{X}]^T$

+ Variance of scalar times a vector
  + $Var(\mathbf{A}\mathbf{X}) = \mathbf{A}Var(\mathbf{X})\mathbf{A}^T$

### Least squares

#### Least squares solution

+ $\hat{\beta} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{y}$

  + $\mathbf{y} = \begin{bmatrix} y_1 \\ y_2 \\ \vdots \\ y_n \end{bmatrix}$,  $\mathbf{X} = \begin{bmatrix} 1 & x_{11} & \cdots & x_{1p} \\ 1 & x_{21} & \cdots & x_{2p} \\ \vdots & \vdots & \ddots & \vdots \\ 1 & x_{n1} & \cdots & x_{np} \end{bmatrix}$,  $\hat{\beta} = \begin{bmatrix} \hat{\beta}_0 \\ \hat{\beta}_1 \\ \vdots \\ \hat{\beta}_p \end{bmatrix}$

+ Hat matrix
  + $\mathbf{H} = \mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T$
  + $\hat{\mathbf{y}} = \mathbf{H}\mathbf{y}$

### Estimation of $\sigma^2$

+ $\hat{\sigma}^2 = s^2 = \frac{1}{n-k-1} \sum_{i=1}^n (y_i - \hat{y}_i)^2$

### Analysis of variance

#### Total sum of squares

+ $SS_{total} = \mathbf{y}^T\mathbf{y} - n\bar{y}^2$
+ $SS_{residual} = \mathbf{y}^T\mathbf{y} - \mathbf{\beta}^T\mathbf{X}^T \mathbf{X} \mathbf{\beta}$
+ $SS_{regression} = \mathbf{\beta}^T\mathbf{X}^T \mathbf{X} \mathbf{\beta} - n\bar{y}^2$
+ $SS_{total} = SS_{regression} + SS_{residual}$
