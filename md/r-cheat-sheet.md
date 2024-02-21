# R Cheat Sheet

## Data structures

```r
# Create a vector
x <- c(1, 2, 3, 4, 5)
x
```

## Basic operations

```r
sum <- sum(x)
mean <- mean(x)
var <- var(x)
sd <- sd(x)
```

## Linear regression

```r
# Fit a linear regression model (y=a+b*temp)
fit=lm(ozone~temp) 
summary(fit)
plot(fit)
```

```r
# Fit a linear regression model with interaction (y=a+b*temp+c*wind+d*temp*I[wind==1])
fit=lm(ozone~temp*wind) #includes temp, wind, and temp:wind
summary(fit)
plot(fit)
```

```r
# Fit a linear regression model with a quadratic term (y=a+b*temp+c*temp^2)
fit=lm(ozone~temp+I(temp^2)) 
summary(fit)
plot(fit)
```

## Quantiles

```r
# Compute quantiles
z_05 <- qnorm(0.5) # Standard normal
qf_05 <- qf(0.5, 2, 3) # F-distribution with 2 and 3 degrees of freedom
```

### Normal Probability Plot

Normal probability plot of residuals is a graphical technique to assess whether the residuals from a model follow a normal distribution. On the x-axis, we have the quantiles of the standard normal distribution. On the y-axis, we have the quantiles of the residuals. If the residuals are normally distributed, the points should fall on a straight line.

**Case 1**: Residuals are normally distributed****

![Normal Residuals](images/normal-probability-plot.png)

One can clearly see that the points fall on a straight line. This means that all residuals observed are consistent with what we would expect if they were normally distributed.

**Case 2**: Residuals are uniformly distributed****

![Uniform Residuals](images/uniform-residuals.png)

One can clearly see that the points do not fall on a straight line. The line curves upwards and then downwards. This means that there are more residuals in the middle and fewer residuals at the tails. This is consistent with a uniform distribution.
