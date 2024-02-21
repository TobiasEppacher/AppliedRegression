# Lecture 9: Logistic Regression

## Introduction

Logistic regression is a statistical model for assessing the associaten between covariates $X = X_1,\ldots,X_p$ and a *binary* outcome $Y$.

## Definitions

- $p(Y=1)$: probability of event of interest, also called *risk*
- $g(\mu) = log(\frac{\mu}{1-\mu})$ is called the *logit link* function
- $Odds(X) = \frac{p(Y=1|X)}{p(Y=0|X)} = \frac{p(Y=1|X)}{1-p(Y=1|X)}$ is the odds of an outcome for a fixed $X$. It says how much higher the probability is for the outcome than for the non-outcome.
- $OR = \frac{Odds(X=1)}{Odds(X=0)}$ is the odds ratio for binary covariates. For continuous covariates, it is the ratio of the odds for a one-unit increase in $X$. For multiple covariates, it is the change for a unit increase in a single variable with all others fixed.

$log\left(\frac{p(Y=1)}{1-p(Y=1)}\right) = \beta_0 + \beta_1 X \implies p(Y=1) = \frac{exp(\beta_0 + \beta_1 X)}{1+exp(\beta_0 + \beta_1 X)} = \sigma(\beta_0 + \beta_1 X)$.
So there is a positive association between $X$ and $p(Y=1)$ if $\beta_1 > 0$ and a negative association if $\beta_1 < 0$.

## Interpretation

$log\left(\frac{p(Y=1|X)}{P(Y=0|X)}\right) = \beta_0 + \beta_1X
\iff
Odds(X) = exp(\beta_0 + \beta_1X)$

It follows that:

- $Odds(X=0) = exp(\beta_0)$
- $Odds(X=1) = exp(\beta_0 + \beta_1)$
- $OR = \frac{Odds(X=1)}{Odds(X=0)} = exp(\beta_1)$
- $\beta_0 = log(Odds(X=0))$
- $\beta_1 = log(OR)$

## Likelihood

In logistic regression, the outcomes $X_i \in \{0,1\}$ are assumed to be independent for $i=1,\ldots,n$ with distributions
$Y_i \sim Ber(\pi(x_i, \beta))$ where $\pi(x_i, \beta) = \frac{exp(x_i^T\beta)}{1+exp(x_i^T\beta)}$.

The likelihood is defined as:
$$
\begin{aligned}
L(\beta) &= \prod_{i=1}^n \pi(x_i, \beta)^{y_i}(1-\pi(x_i\beta))^{1-y_i} \\
&= \prod_{i=1}^n \left(\frac{exp(x_i^T\beta)}{1+exp(x_i^T\beta)}\right)^{y_i}\left(\frac{1}{1+exp(x_i^T\beta)}\right)^{1-y_i} \\
&= \prod_{i=1}^n \frac{exp(x_i^T\beta Y_i)}{1+exp(x_i^T\beta)} \\
&= \frac{exp[(\sum_{i=1}^n Y_i x_i^T)\beta]}{\prod_{i=1}^n (1+exp(x_i^T\beta))} \\
\end{aligned}
$$

The mle $\hat{\beta}$ is found using the Newton-Raphson algorithm applied to $-logL(\beta)$.

## Constellations

The likelihood can be reduced by compacting the data points that have the same $X$ values, called *constellations*.

Let $m$ denote the number of unique constellations $x_i$, $n_k$ the number of data points with this constallation and $y_k$ the number of these equal to 1. Then the likelihood becomes proportional to that of the binomial distribution:
$$L(\beta) \propto \prod_{k=1}^m \pi(x_k, \beta)^{y_k}(1-\pi(x_k, \beta))^{n_k-y_k}$$

$$logL(\beta) \propto \sum_{k=1}^{m}{y_klog[\pi(x_k,\beta)] + (n_k-y_k)log[1-\pi(x_k,\beta)]} $$

The derivatives of the log-likelihood are given by:
$$\frac{\partial logL(\beta)}{\partial \beta} = \sum_{k=1}^m [y_k - n_k\pi(x_k,\beta)]x_k \in \mathbb{R}^p$$
$$\frac{\partial^2 logL(\beta)}{\partial X^2} = \sum_{k=1}^m n_k\pi[x_k,\beta](1-\pi(x_k,\beta))x_kx_k^T \in \mathbb{R}^{p \times p}$$

## Confidence intervals and tests of hypotheses

The variance of $\hat{\beta}$ is approximated by
$$Var(\hat{\beta}) \approx \left(\frac{\partial^2 logL(\beta)}{\partial X^2}\right)^{-1}$$

This comes from the taylor expansion of the log-likelihood around $\hat{\beta}$:

For $j=1,\ldots,p$:

- se($\hat{\beta}_j$) = $\sqrt{Var(\hat{\beta})_{jj}}$
- 100(1-$\alpha$)% CI for log OR: $\hat{\beta}_j \pm z_{1-\alpha/2}se(\hat{\beta}_j)$
- 100(1-$\alpha$)% CI for OR: $exp(\hat{\beta}_j \pm z_{1-\alpha/2}se(\hat{\beta}_j))$
- Test: $H_0: \beta_j = 0$ vs. $H_A: \beta_j \neq 0$: $\frac{\hat{\beta}_j}{se(\hat{\beta}_j)} \sim N(0,1)$

### Likelihood ratio test

Assume a restricted model $x_{res} \subset x$ with log odds ratios $\beta_{res}$:

$$H_{restrict}: x_{res}^T\beta_{res}$$
$$H_{full}: x^T\beta$$

LRT statistics = $-2log\left(\frac{L(\hat{\beta})}{L(\hat{\beta_{res}})}\right) \sim \chi^2_{dim(\beta)-dim(\beta_{res})}$ under $H_{restrict}$, where $\hat{\beta}$ and $\hat{\beta_{res}}$ are the mle's of the full and restricted model. Using the previous results it can be shown that
$$\text{LRT statistics} = \sum_{k=1}^m {y_klog\left[\frac{\pi(x_k, \hat{\beta})}{\pi(x_k\hat{\beta_{res}})}\right]} + (n_k-y_k)log\left[\frac{1-\pi(x_k, \hat{\beta})}{1-\pi(x_k\hat{\beta_{res}})}\right]$$

### Deviance

Suppose there are $m<<n$ constellations such that each constellation could get its own probability $pi_k$:
$$H_full: x^T\beta$$
$$H_{saturated}: \text{constellation-specific probabilities} (\pi_1,\ldots,\pi_m)$$

The LRT statistic is used, but here referred to as the *deviance*:
$$D = -2log\left(\frac{L(\hat{\pi_1},\ldots,\hat{\pi_m})}{L(\hat{\beta})}\right) \sim \chi_{n-dim(\beta)} \text{under} H_{full}$$
Where $\hat{\pi}$ is the mle of the saturated model and given by $\hat{\pi_k} = \frac{y_k}{n_k}$. Therefore, the deviance can be re-written as:
$$D = 2\sum_{k=1}^m {y_klog\left[\frac{\hat{\pi_k}}{\pi(x_k,\hat(\beta))}\right] + (n_k-y_k)log\left[\frac{1-\hat(\beta_k)}{1-\pi(x_k,\hat(\beta))}\right]}$$

$$\text{LRT} = 2[logL(full)-logL(restrict)] = 2[logL(saturated)-logL(restricted) - logL(saturated) + logL(full)] = D(restricted)-D(full)$$

In R, the residual deviance at the bottom of the output refers to the hypothesis $H_{full}$ vs $H_{saturated}$ which tests the goodness of fit of the specified model, including the intercept.
The null deviance at the bottom of the output refers to the hypothesis $H_{intercept}$ vs $H_{saturated}$ which tests the intercept-only model. We can therefore run the restricted and full model to compute the LRT statistics in R.
