# Title     :
# Objective :
# Created by: mgutierrez
# Created on: 15-02-2021

# Ej5
m <- 1e5

theta <- rbeta(m, shape1=5.0, shape2=3.0)

odd_success <- theta / (1 - theta)
mean(odd_success)

# Ej6
ind <- odd_success > 1.0
mean(ind)

# Ej7
y <- rnorm(m, mean=0, sd=1)
quantile(y, probs=0.3)
qnorm(0.3, mean=0, sd=1)

# Ej8
se <- sqrt(5.2/5000)