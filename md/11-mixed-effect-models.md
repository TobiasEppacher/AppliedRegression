# Lecture 11: Mixed Effect Models

Mixed effect models are used to model the same data for a number of different people. For example, 4 people take 10 blood pressure measurements each spread over 3 months. The data is then modeled using a mixed effect model.

The questions are:

1. What is the population average blood pressure?
2. What is the deviation of each person from the population average?
3. What is the deviation of each measurement from the person's average?

The model is:

$$
y_{ij} = \underbrace{\beta_0}_{\text{population average}} + \underbrace{b_i}_{\text{person deviation}} + \underbrace{e_{ij}}_{\text{measurement deviation}}
$$

where $y_{ij}$ is the $j$-th measurement of the $i$-th person, $\beta_0$ is the population average, $b_i$ is the deviation of the $i$-th person from the population average and $e_{ij}$ is the deviation of the $j$-th measurement of the $i$-th person from the person's average. Its assumed that $b_i \sim N(0,d)$ and $e_{ij} \sim N(0, \sigma_e^2)$.

The mean of the model is:

$$
E[y_{ij}] = E[\beta_0 + b_i + e_{ij}] = \beta_0
$$

The variance of the model is:

$$
Var(y_{ij}) = Var(\beta_0 + b_i + e_{ij}) = d + \sigma_e^2
$$

The covariance of the model is:

$$
\begin{aligned}
Cov(y_{ij}, y_{km}) &= 0 \quad \text{for $i \neq k$ as people are independent}\\
Cov(y_{ij}, y_{ij}) &= d + \sigma_e^2 \\
Cov(y_{ij}, y_{ik}) &= Cov(\beta_0 + b_i + e_{ij}, \beta_0 + b_i + e_{ik})\\
&= Cov(b_i + e_{ij}, b_i + e_{ik}) \\
&= Cov(b_i, b_i) + Cov(b_i, e_{ik}) + Cov(e_{ij}, b_i) + Cov(e_{ij}, e_{ik}) \\
&= d + 0 + 0 + 0 \\
\end{aligned}
$$

The correllation is defined as:

$$
Cor({ij}, y_{km}) = \frac{Cov(y_{ij}, y_{km})}{\sqrt{Var(y_{ij})Var(y_{km})}}
$$

In this model this turns out to be:

$$
\begin{aligned}
Cor({ij}, y_{km}) &= 0 \quad \text{for $i \neq k$ as people are independent} \\
Cor({ij}, y_{ik}) &= \frac{d}{d + \sigma_e^2} \quad \text{between measurements of the same person}\\
Cor({ij}, y_{ij}) &= 1 \quad \text{for the same measurement}
\end{aligned}
$$
