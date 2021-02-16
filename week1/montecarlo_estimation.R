# Title     : Montecarlo Estimation
# Objective : Compare real parameter vs estimated parameter.
# Created by:
# Created on: 15-02-2021

set.seed(32)


m <- 10000
a <- 2.0
b <- 1.0/ 3.0

theta <- rgamma(n=m, shape=a, rate=b)  # Random gamma

hist(theta, freq=FALSE)
curve(dgamma(x, shape=a, rate=b), col="blue", add=TRUE)

sum(theta) / m
mean(theta)
a / b

var(theta)
a / b^2

ind <- theta < 5.0
mean(ind)

pgamma(q=5.0, shape=a, rate=b)

quantile(theta, probs=0.9)
qgamma(p=0.9, shape=a, rate=b)


#############################
# Standard error
###############

# Intervalor de confianza donde se encuentra theta
se <- sd(theta) / sqrt(m)

mean(theta) - 2.0*se
mean(theta) + 2.0*se


ind <- theta < 5.0
mean(ind)
pgamma(5.0, shape=a, rate=b)

se = sd(ind) / sqrt(m)