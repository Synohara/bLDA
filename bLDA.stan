
data {
  int<lower=1> E;
  int<lower=1> N;
  int<lower=1> I;
  int<lower=1> K;
  int<lower=1, upper=N> DocumentID[E];
  int<lower=1, upper=I> WordID[E];
  vector<lower=0>[K] Alpha;
  vector<lower=0>[I] Beta;
  real balance[E];
}

parameters {
  
  simplex[I] phi[K];
  simplex[K] theta[N];
  vector<lower=0>[2] ab[K];
  vector[2] ab0;
  vector[2] ab1;

}

model {
  for (k in 1:K)
    phi[k] ~ dirichlet(Beta);
  for (n in 1:N)
    theta[n] ~ dirichlet(Alpha);
  // likelihood
  for (e in 1:E) {
    real eta[K];
    real gamma[K];
    for (k in 1:K){
      gamma[k] = log(theta[DocumentID[e],k]) + lognormal_lpdf(balance[e] | ab[k,1],ab[k,2]);
      eta[k] = log(theta[DocumentID[e],k]) + log(phi[k,WordID[e]]);
    }
    target += log_sum_exp(gamma);
    target += log_sum_exp(eta);
      }
    }
  
