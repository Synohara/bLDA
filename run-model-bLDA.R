library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

d_kaken <- d_kaken
N <- length(parsed[1,])
K <- 10
I <- length(parsed[,1])
#document <- matrix(d_kaken$DocumentID,3,nrow(d_kaken),byrow=T)
#word <- matrix(d_kaken$WordID,3,nrow(d_kaken),byrow=T)
#balance_list <- matrix(d_kaken$Balance,3,nrow(d_kaken),byrow=T)
data <- list(
  E=nrow(d_kaken), N=N, I=I, K=K,
  DocumentID=d_kaken$DocumentID, WordID=d_kaken$WordID, Alpha=rep(0.8, K),Beta=rep(0.2,I),
  balance=d_kaken$Balance
)

stanmodel <- stan_model(file='bLDA/bLDA.stan')
fit_nuts_bLDA <- sampling(stanmodel, data=data, seed=123)
#fit_vb_bLDA <- vb(stanmodel, data=data, seed=123)

save.image('output/result-model11-8.RData')
