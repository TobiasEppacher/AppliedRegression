# Lecture 10: Poisson Regression

Poisson regression is used to model count data. The main goal is to forecast future natural numbers. The Poisson distribution is used to model the number of events that occur in a fixed interval of time or space. Like the number of accidents at a traffic intersection, the number of calls at a call center, the number of patients in a hospital, etc.

## Poisson Distribution

The Poisson distribution is a discrete probability distribution that expresses the probability of a given number of events occurring in a fixed interval of time or space. It is defined as:

$$
P(Y=y) = \frac{e^{-\mu}\mu^y}{y!}
$$

where $k$ is the number of events, $\lambda$ is the average number of events in the interval and $e$ is Euler's number.

The mean and variance of the Poisson distribution are both equal to $\lambda$.

The Log-Link function is used to model the mean of the Poisson distribution:

$$
\log(\mu) = \beta_0 + \beta_1 X_1 + \ldots + \beta_p X_p
$$

## Likelihood

The likelihood is defined as:

$$
L(\beta) = \prod_{i=1}^n \frac{e^{-\mu_i}\mu_i^{y_i}}{y_i!} \propto \prod_{i=1}^n e^{-\mu_i}\mu_i^{y_i}
$$

where $\mu_i = \exp(x_i^T\beta)$.

The mle $\hat{\beta}$ is found using the Newton-Raphson algorithm applied to $-logL(\beta)$.
