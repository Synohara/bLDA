N <- 50
I <- 100
K <- 6
set.seed(123)
alpha0 <- rep(0.8, K)
alpha1 <- rep(0.2, I)
a <- c(2,5,2,5,2,5)
b <- c(5,2,5,2,5,2)
theta <- gtools::rdirichlet(N, alpha0)
phi <- gtools::rdirichlet(K, alpha1)

num_items_by_n <- round(exp(rnorm(N, 6.0, 0.5)))

d_bLDA <- data.frame()
  for (n in 1:N) {
    z <- sample(K, num_items_by_n[n], prob=theta[n,], replace=TRUE)
    balance <- rbeta(num_items_by_n[n],a[as.integer(which.max(theta[n,]))],b[as.integer(which.max(theta[n,]))]) #文書の中で最頻のトピックのインデックスを選んでくる
    item <- sapply(z, function(k) sample(I, 1, prob=phi[k,]))
    d_bLDA <- rbind(d_bLDA, data.frame(PersonID=n, ItemID=item,Balance=balance))
  }