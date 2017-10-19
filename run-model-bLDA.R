library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

d_bLDA <- d_bLDA
N <- N
K <- K
I <- I
person <- matrix(d_bLDA$PersonID,3,nrow(d_bLDA),byrow=T)
item <- matrix(d_bLDA$ItemID,3,nrow(d_bLDA),byrow=T)
balance_list <- matrix(d_bLDA$Balance,3,nrow(d_bLDA),byrow=T)
data <- list(
  E=nrow(d_bLDA), N=N, I=I, K=K,
  PersonID=d_bLDA$PersonID, ItemID=d_bLDA$ItemID, Alpha=rep(0.8, K),Beta=rep(0.2,I),
  balance=d_bLDA$Balance
)

stanmodel <- stan_model(file='bLDA.stan')
#fit_nuts_bLDA <- sampling(stanmodel, data=data, seed=123)
fit_vb_bLDA <- vb(stanmodel, data=data, seed=123)

save.image('output/result-model11-8.RData')