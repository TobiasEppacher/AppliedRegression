# Formulas Cheat Sheet

## Probability

Let $X, Y$ be random variables and $a, b$ constants.

### Expected value

+ Expected value of a constant
  + $E(a) = a$
  
+ Linearity of expectation
  + $E(aX + bY) = aE(X) + bE(Y)$

+ Sample mean
  + $\bar{x} = \frac{1}{n} \sum_{i=1}^n x_i$

### Variance

+ Variance of a constant
  + $Var(X) = E[(X - \mu)^2] = E(X^2) - E(X)^2$

+ Variance of an additive constant
  + $Var(aX+b) = a^2 Var(X)$
  
+ Variance of a linear combination
  + $Var(aX + bY) = a^2 Var(X) + 2ab Cov(X, Y) + b^2 Var(Y)$

+ Sample variance
  + $var_x = \frac{1}{n-1} S_{xx} = \frac{1}{n-1} \sum_{i=1}^n (x_i - \bar{x})^2$

### Standard error

+ Standard error of a random variable
  + $sd(X) = \sqrt{Var(X)}$

### Covariance

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

### Correlation

+ Definition
  + $cor(X, Y) = \frac{Cov(X, Y)}{sd(X) sd(Y)} = \frac{Cov(X, Y)}{\sqrt{Var(X) Var(Y)}}$
