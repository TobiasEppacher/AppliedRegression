# Lecture 5: Model Selection

The job of model selection is to find the best model for a given dataset. This is done by comparing different models using a criterion that measures the "quality" of the model.

## Introduction

To many parameters can increase the variance of the fitted values. To few parameters can increase the bias. The goal is to find a model that minimizes both. We only want to include parameters that are necessary to explain the data.

## Possible Selection Criteria

### All Subsets Regression

When having a dataset with $k$ parameters, there are $2^k$ possible model, just by including or excluding each parameter. One could fit all these models and compare them using a criterion.

This is not feasible for large $k$.

### $R^2$ Statistic

The problen with $R^2$ is that it always increases when adding more parameters. It is not a good criterion for model selection since the bigger model will always win.

### Adjusted $R^2$

The adjusted $R^2$ is a modification of the $R^2$ that penalizes the number of parameters. It is defined as:

$$
\begin{aligned}
R^2_{adj} &= 1 - \frac{SS_{residual} / (n-k-1)}{SS_{total} / (n-1)}
\qquad \left(= 1- \frac{N-1}{N-k-1}(1-R^2)\right)\\ &= 1 - \frac{s^2}{SS_{total} / (n-1)}
\end{aligned}
$$

where $s^2$ is the estimated variance of the residuals. This means that when using the adjusted $R^2$ as a criterion, the model with the lowest $s^2$ and the highest $SS_{total}$ will win.

The optimal model is the one that maximizes the adjusted $R^2$.

### AIC

The Akaike Information Criterion is defined as:

$$
AIC = -2 \log(\mathcal{L}) + 2(k+1)
$$

In the case of linear regression with normally distributed errors, the AIC is equivalent to:

$$
AIC = n \log \left(\frac{SS_{residual}}{n}\right) + 2(k+1) + const
$$

where $n$ is the number of observations and $k$ is the number of parameters withou the intercept. The optimal model is the one that minimizes the AIC.

The AIC tries to select a model that fits the data well, but uses as few parameters as possible.

### BIC

The Bayesian Information Criterion is defined as:

$$
BIC = -2 \log(\mathcal{L}) + \log(n)(k+1)
$$

In the case of linear regression with normally distributed errors, the BIC is equivalent to:

$$
BIC = n \log \left(\frac{SS_{residual}}{n}\right) + \log(n)(k+1) + const
$$

where $n$ is the number of observations and $k$ is the number of parameters withou the intercept. The optimal model is the one that minimizes the BIC.

The BIC tries to select a model that fits the data well, but uses as few parameters as possible. Additionaly it selects the model that needed the fewest training data to fit the model.

## Automatic Model Selection

### Forward Selection

Idea: Start with the null model and add one parameter at a time. At each step, add the parameter that gives the best improvement in the criterion.

```python
M = [] # M is intercept only at the beginning
current_AIC = fit_model(M)

while True:
    best_covariate = None
    best_AIC, best_covariate = np.inf, None

    # go through all bigger models and select the one with the best criterion
    for covariate in all_remaining_covariates:
        M_new = M + covariate
        AIC = fit_model(M_new)

        if AIC < best_AIC:
            best_AIC, best_covariate = AIC, covariate

    # if the best model is better than the current model, add the covariate
    if best_AIC < current_AIC:
        M = M + best_covariate
        current_AIC = best_AIC
    else:
        break
```

If a covariate is added, it is never removed again.

### Backward Selection

Idea: Start with the full model and remove one parameter at a time. At each step, remove the parameter that gives the best improvement in the criterion.

```python
M = all_covariates # M is full model at the beginning
current_AIC = fit_model(M)

while True:
    best_covariate = None
    best_AIC, best_covariate = np.inf, None

    # go through all smaller models and select the one with the best criterion
    for covariate in all_remaining_covariates:
        M_new = M - covariate
        AIC = fit_model(M_new)

        if AIC < best_AIC:
            best_AIC, best_covariate = AIC, covariate

    # if the best model is better than the current model, remove the covariate
    # this may happen because fewer parameters are punished less. However, the
    # model error may increase.
    if best_AIC < current_AIC:
        M = M - best_covariate
        current_AIC = best_AIC
    else:
        break
```

If a covariate is removed, it is never added again.

### Stepwise Selection

Idea: Start with some model and add or remove one parameter at a time. At each step do a forward step and a backward step and select the best model.

```python
M = [] # M is intercept only at the beginning
current_AIC = fit_model(M)
threshold = 0.05

while True:

    ### Forward step

    best_AIC_forward, best_covariate = np.inf, None

    # go through all bigger models and select the one with the best criterion
    for covariate in all_remaining_covariates:
        M_new = M + covariate
        AIC = fit_model(M_new)

        if AIC < best_AIC_forward:
            best_AIC_forward, best_covariate = AIC, covariate

    # if the best bigger model is better than the current model, add the covariate
    if best_AIC_forward < current_AIC:
        M = M + best_covariate
        current_AIC = best_AIC_forward

    # if the improvement is not big enough, stop
    if best_AIC_forward - current_AIC < threshold:
        break

    ### Backward step

    best_AIC_backward, best_covariate = np.inf, None

    # go through all smaller models and select the one with the best criterion
    for covariate in all_remaining_covariates:
        M_new = M - covariate
        AIC = fit_model(M_new)

        if AIC < best_AIC_backward:
            best_AIC_backward, best_covariate = AIC, covariate

    # if the improvement is not big enough, stop
    if best_AIC_backward - current_AIC < threshold:
        break

    # if the best smaller model is better than the current model, remove the covariate
    if best_AIC_backward < current_AIC:
        M = M - best_covariate
        current_AIC = best_AIC_backward
    else:
        break
```

Aslong as the improvement is big enough, the algorithm will continue to add and remove covariates. Covariates can enter and leave the model multiple times.
