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
transpose <- t(x)
round <- round(x, 2)
sort <- sort(x)
```

## Linear regression

```r
# Fit a linear regression model (y=a+b*temp)
fit=lm(ozone~temp, data=airquality)
summary(fit)
plot(fit)
```

```r
# Fit a linear regression model with interaction (y=a+b*temp+c*wind+d*temp*I[wind==1])
fit=lm(ozone~temp*wind, data=airquality) #includes temp, wind, and temp:wind
summary(fit)
plot(fit)
```

```r
# Fit a linear regression model with a quadratic term (y=a+b*temp+c*temp^2)
fit=lm(ozone~temp+I(temp^2),data=airquality) 
summary(fit)
plot(fit)
```

```r
# Fit a linear regression model without an intercept (y=b*temp)
fit=lm(ozone~temp-1,data=airquality)
summary(fit)
plot(fit)
```

Using the `factor` function, we can include categorical variables in the model. The `factor` function automatically creates the dummy variables for us.

```r
# Fit a linear regression model with a categorical variable (y=a+b*temp+c*factor(month))
fit=lm(ozone~temp+factor(month),data=airquality)
summary(fit)
plot(fit)
```

```r
# Fit an adapted linear model (log(y)=a+b*temp+c*factor(month))
fit=lm(log(ozone)~temp+factor(month),data=airquality)
summary(fit)
plot(fit)
```

### Model selection

```r
# Fit a linear regression model with all possible predictors
fit=lm(ozone~.,data=airquality)
summary(fit)
```

```r
# Use the stepwise selection method to select the best model using the forward selection method with the AIC criterion
stepAIC(lm(log(ozone)~temp,data=airquality, direction="forward", scope=list(upper=~temp, lower=~1)))
```

## Nonlinear regression

```r
# Fit a nonlinear regression model (clor~a+(0.49-a) * exp(-b*(age-8))
fit=nls(clor~a+(0.49-a) * exp(-b*(age-8)),data=chlorine, start=list(a=0.1, b=0.1))
summary(fit)
plot(fit)
```

The `nls` function is used to fit a nonlinear regression model. The `start` argument is used to provide initial values for the parameters. It uses the Newton-Raphson method to find a local minimum of the sum of squares.

```r
# Compute quantiles
z_05 <- qnorm(0.5) # Standard normal
qf_05 <- qf(0.5, 2, 3) # F-distribution with 2 and 3 degrees of freedom
```

## Plotting

```r
# Create a scatter plot
plot(x, y, main="Scatterplot Example", xlab="X Axis", ylab="Y Axis")
```

```r
# Plot linear regression
fit=lm(y~x)
plot(fit)
```

### Autocorellation

```r
# Compute the autocorrelation of a time series (lag=1)
acf(residuals(fit),las=1)
```

### Normal Probability Plot

Normal probability plot of residuals is a graphical technique to assess whether the residuals from a model follow a normal distribution. On the x-axis, we have the quantiles of the standard normal distribution. On the y-axis, we have the quantiles of the residuals. If the residuals are normally distributed, the points should fall on a straight line.

**Case 1**: Residuals are normally distributed****

![Normal Residuals](images/normal-probability-plot.png)

One can clearly see that the points fall on a straight line. This means that all residuals observed are consistent with what we would expect if they were normally distributed.

**Case 2**: Residuals are uniformly distributed****

![Uniform Residuals](images/uniform-residuals.png)

One can clearly see that the points do not fall on a straight line. The line curves upwards and then downwards. This means that there are more residuals in the middle and fewer residuals at the tails. This is consistent with a uniform distribution.

## Tests

### Durbins-Watson Test

```r
# Compute the Durbin-Watson test statistic
dwtest(fit, alternative="two.sided")
```

## Time series

The `gls` (Generalized Least Squares) function is used to fit a generalized least squares model. The `correlation` argument is used to specify the correlation structure of the errors. The `corARMA` function is used to specify an ARMA correlation structure.

```r
# Fit a generalized least squares model (AR1 model)
fit=gls(y~x,correlation=corARMA(p=1,q=0),data=dat)
summary(fit)
```

```r
# Fit a generalized least squares model (AR2 model)
fit=gls(y~x,correlation=corARMA(p=2,q=0),data=dat)
summary(fit)
```

## Logistic regression

Using the `glm` function, we can fit a logistic regression model. The `family` argument is used to specify the distribution of the response variable. The `link` argument is used to specify the link function.

```r
# Fit a logistic regression model
fit=glm(Surv~Gender+Age,family=binomial(link="binomial"),data=dat)
summary(fit)
```

## Poisson regression

Using the `glm` function, we can fit a Poisson regression model. The `family` argument is used to specify the distribution of the response variable. The `link` argument is used to specify the link function.

```r
# Fit a Poisson regression model
fit=glm(Matings~Age,family="poisson",data=dat)
summary(fit)
```

## Linear Mixed Models

The `lme` function is used to fit a linear mixed model. The `random` argument is used to specify the random effects. The `correlation` argument is used to specify the correlation structure of the random effects.

```r
# Fit a linear mixed model
fit=lme(y~x,random=~1|group,correlation=corARMA(p=1,q=0),data=dat)
summary(fit)
```
