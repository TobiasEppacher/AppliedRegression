# Formulas Linear Regression

+ Base model: $y = \beta_0 + \beta_1 x_1 + \epsilon$, where $\epsilon \sim N(0, \sigma^2)$

+ $\beta_0$ is the intercept, $\beta_1$ is the slope of the line.

## Least Squares

### Finding the fitted line

Minimize the sum of squared residuals, to obtain the least squares estimates $\hat{\beta_0}$ and $\hat{\beta_1}$:

+ $\hat{\beta_1} = \frac{\sum_{i=1}^n \left( x_i - \bar{x} \right) \left( y_i - \bar{y} \right)}{\sum_{i=1}^n \left( x_i - \bar{x} \right)^2}  = \frac{S_{xy}}{S_{xx}}$
  + Can also be written as $\hat{\beta_1} = \sum_{i=1}^n c_i y_i$

+ $\hat{\beta_0} = \bar{y} - \hat{\beta_1} \bar{x}$

Both estimates are unbiased. Meaning that $E(\hat{\beta_0}) = \beta_0$ and $E(\hat{\beta_1}) = \beta_1$.

### Variances of the estimates

+ $Var(\hat{\beta_1}) = \frac{\sigma^2}{S_{xx}}$
+ $Var(\hat{\beta_0}) = \sigma^2 \left( \frac{1}{n} + \frac{\bar{x}^2}{S_{xx}} \right)$

In practices $\sigma^2$ is unknown and is estimated by $s^2$.

### Variability of the data around the fitted line

+ $s^2 = \frac{1}{n-2} \sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2 = \frac{SSE}{n-2}$ measured the variabilty
  + $y_i = \hat{\beta_0} + \hat{\beta_1} x_i + \epsilon_i$ is the point
  + The expression for $s^2$ can be deduced via Maximum Likelihood Estimation (MLE) of $\sigma^2$.

Using this estimate we can evaulate the Variances of of $\hat{\beta_0}$ and $\hat{\beta_1}$:

+ $Var(\hat{\beta_1}) \approx \frac{s^2}{S_{xx}}$
+ $Var(\hat{\beta_0}) \approx s^2 \left( \frac{1}{n} + \frac{\bar{x}^2}{S_{xx}} \right)$

Standard error is defined as the square root of the variance of the estimate:

+ $se(\hat{\beta_1}) = \sqrt{Var(\hat{\beta_1})} \approx \frac{s}{\sqrt{S_{xx}}}$
+ $se(\hat{\beta_0}) = \sqrt{Var(\hat{\beta_0})} \approx s \sqrt{\frac{1}{n} + \frac{\bar{x}^2}{S_{xx}}}$

### Prediction of the mean at a fixed $x_{new}$

+ The model is still $y = \beta_0 + \beta_1 x + \epsilon$, where $\epsilon \sim N(0, \sigma^2)$

To predict the mean of $y_{mean}$ for a new $x_{new}$ we use the following formulas:

+ $y_{mean} = E[y_e] = \beta_0 + \beta_1 x_{new} \approx \hat{\beta_0} + \hat{\beta_1} x_{new}$

The variance of the mean value at position $x_{new} is given by:

+ $Var(y_{mean}) = Var(\hat{\beta_0} + \hat{\beta_1} x_{new}) = \sigma^2 \left( \frac{1}{n} + \frac{\left( x_{new} - \bar{x} \right)^2}{S_{xx}} \right)$
  + Plugging in $x_{new} = 0$ or $x_{new} = \bar{x}$ yields the variance of the intercept and the slope as seen in the previous section.

### Prediction of a new observation $y_{new}$ at a fixed $x_{new}$

+ Using the same model as before: $y = \beta_0 + \beta_1 x_1 + \epsilon$, where $\epsilon \sim N(0, \sigma^2)$

+ The expected value of a new observation at position $x_{new}$ is exactly the $y_{mean}$ from the previous section.

+ The variance can be calculated as follows:

  + $Var(y_e) = Var(\hat{\beta_0} + \hat{\beta_1} x_{new} + \epsilon_e) = \sigma^2 \left( 1 + \frac{1}{n} + \frac{\left( x_{new} - \bar{x} \right)^2}{S_{xx}} \right)$

  + The variance of the error term is added to the variance of the mean value.

## T-Test

### Hypothesis

We want to test the hypothesis $H_0: \beta_1 = 0$ against $H_1: \beta_1 \neq 0$. The null hypothesis states that the covariate has no effect on the outcome. Meaning that there is absolutely no linear association between the two variables.

### Test Parameter

We use $T = \frac{\hat{\beta_1}}{se(\hat{\beta_1})} \sim t_{n-2}$ as the test parameter. This is the ratio of the estimated slope and its standard error. The distribution of this parameter is a t-distribution with $n-2$ degrees of freedom.

### Quantile Approach

$t_{n-2,1-\frac{\alpha}{2}}$ is the $1-\frac{\alpha}{2}$ quantile of the $t_{n-2}$ distribution. We reject the null hypothesis if $|T| > t_{n-2,1-\frac{\alpha}{2}}$.

### P-Value Approach

$p = 2 \cdot (1 - P(t < |T|)), t \sim t_{n-2}$ is the probability of a result as or more extreme than the observed. We reject the null hypothesis if $p < \alpha$.

### Confidence Intervals

A confidence interval is a random interval that covers the true value of $\beta_1$ with probability $1-\alpha$. For arbitrary $\alpha$ we can calculate the confidence interval as:

+ $X \pm t_{n-2, 1-\frac{\alpha}{2}} \cdot se(X)$

### Confidence Interval for $\beta_1$

The confidence interval for $\beta_1$ (with accuracy $1-\alpha$) is given by

$$
\hat{\beta_1} \pm t_{n-2, 1-\frac{\alpha}{2}} \cdot se(\hat{\beta_1})
$$

### Confidence Interval for $y_{mean}$ at a fixed $x_{new}$

The confidence interval for $y_{mean}$ (with accuracy $1-\alpha$) at a fixed $x_{new}$ is given by:

$$
\hat{\beta_{0}} + \hat{\beta_1} x_{new} \pm t_{n-2, 1-\frac{\alpha}{2}} \cdot se(\hat{\beta_0} + \hat{\beta_1} x_{new})
$$

where $se(\hat{\beta_0} + \hat{\beta_1} x_{new})$ can be calculated as: $se(\hat{\beta_0} + \hat{\beta_1} x_{new}) \approx s \sqrt{\frac{1}{n} + \frac{\left( x_{new} - \bar{x} \right)^2}{S_{xx}}}$ as seen previously.

### Confidence Interval for $y_{new}$ at a fixed $x_{new}$

The confidence interval for $y_{new}$ (with accuracy $1-\alpha$) at a fixed $x_{new}$ is given by:

$$
\hat{\beta_{0}} + \hat{\beta_1} x_{new} \pm t_{n-2, 1-\frac{\alpha}{2}} \cdot se(\hat{\beta_0} + \hat{\beta_1} x_{new} + \epsilon_e)
$$

where $se(\hat{\beta_0} + \hat{\beta_1} x_{new} + \epsilon_e)$ can be calculated as: $se(\hat{\beta_0} + \hat{\beta_1} x_{new} + \epsilon_e) \approx s \sqrt{1 + \frac{1}{n} + \frac{\left( x_{new} - \bar{x} \right)^2}{S_{xx}}}$ as seen previously.

## ANOVA

The ANOVA table is used to test the hypothesis $H_0: \beta_1 = 0$ against $H_1: \beta_1 \neq 0$. It computes the $F$ value of the regression which is then used to test the hypothesis.

### Total Variation

The total variation of the data is given by:

$$
\underbrace{\sum_{i=1}^n \left( y_i - \bar{y} \right)^2}_{SS_{total}} = \underbrace{\sum_{i=1}^n \left( \hat{y}_i - \bar{y} \right)^2}_{SS_{regression}} + \underbrace{\sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2}_{SS_{residual}}
$$

+ $SS_{total}$ is the **total** variation of the data, its the sum of the squared deviations of the data from its mean.
  + This calculation has $n-1$ degrees of freedom.
+ $SS_{regression}$ is the variation explained by the **model**. It measures how much the fitted values differ from the mean.
  + This calculation has $1$ degree of freedom.
+ $SS_{residual}$ is the **residual** variation, it meausres the random **error** of the data around the fitted line.
  + This calculation has $n-2$ degrees of freedom.

### F-Test

The F-Test is used to test the hypothesis $H_0: \beta_1 = 0$ against $H_1: \beta_1 \neq 0$ in another way. It obtains the **same** result as the t-test.

The test parameter is given by:

$$
F = \frac{SS_{regression}}{SS_{residual}} \cdot \frac{n-2}{1} \sim F_{1, n-2}
$$

The Null hypothesis is rejected equivalently if either:

+ $F > F_{1, n-2, 1-\alpha}$ (Quantile approach)
+ $P(f > F) < \alpha$ where $f \sim F_{1, n-2}$. (P-Value approach)

### $R^2$ Percentage of variation explained by the model

To measure how much of the variation is explained by the model we can use the following formula:

$$
R^2 = \frac{SS_{regression}}{SS_{total}} = 1 - \frac{SS_{residual}}{SS_{total}}
$$

The value $R^2$ can be interpreted as the percentage of the variation explained by changes in the covariate $x$.

### Pearson's Correlation Coefficient

Another measure of the *linear* association between two variables is the Pearson's Correlation Coefficient. It is given by:

$$
r = sgn(\hat{\beta_1}) \sqrt{R^2} = \frac{S_{xy}}{\sqrt{S_{xx} S_{yy}}}
$$

The value $r$ is between -1 and 1. It is 1 if the two variables are perfectly correlated, -1 if they are perfectly anti-correlated and 0 if they are not correlated at all. The formula is symmetric, meaning that $r(x,y) = r(y,x)$.
