# Title     :
# Objective : Percentage change in total personnel from last year to this year for ten
# companies
# Created by: mgutierrez
# Created on: 16-02-2021

lg <- function(mu, n, ybar){
  mu2 <- mu^2
  n * (ybar*mu - mu2 / 2.0) - log(1.0 + mu2)
}

mh <- function(n, ybar, n_iter, mu_init, cand_sd){
  mu_out <- numeric(n_iter)
  accpt <- 0
  mu_now <- mu_init
  lg_now <- lg(mu=mu_now, n=n, ybar=ybar)

  for (i in 1:n_iter){
    mu_cand <- rnorm(1, mean=mu_now, sd=cand_sd)

    lg_cand <- lg(mu=mu_cand, n=n, ybar=ybar)
    lalpha <- lg_cand - lg_now
    alpha <- exp(lalpha)

    u <- runif(1)
    if (u < alpha){
      mu_now <- mu_cand
      accpt <- accpt + 1
      lg_now <- lg_cand
    }

    mu_out[i] <- mu_now
  }
  list(mu=mu_out, accpt=accpt/n_iter)
}

## set up
y <- c(1.2, 1.4, -0.5, 0.3, 0.9, 2.3, 1.0, 0.1, 1.3, 1.9)

ybar <- mean(y)
n <- length(y)

hist(y, freq=FALSE, xlim=c(-1.0, 3.0))
points(y, rep(0.0, n))
points(ybar, 0.0, pch=19)
curve(dt(x, df=1), lty=2, add=TRUE)


## posterior sampling
set.seed(43)
post <- mh(n=n, ybar=ybar, n_iter=1e3, mu_init=30.0, cand_sd = 0.9)
str(post)

install.packages("coda")
library("coda")

traceplot(as.mcmc(post$mu))


### post analysis
post$mu_keep <- post$mu[-c(1:100)]
plot(density(post$mu_keep), xlim=c(-1.0, 3.0))