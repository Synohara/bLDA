library(ggplot2)

#load('output/result-model11-8.RData')
ms <- rstan::extract(fit_vb_bLDA)
probs <- c(0.1, 0.25, 0.5, 0.75, 0.9)
idx <- expand.grid(1:N, 1:K)
n <- 1
d_qua <- t(apply(idx, 1, function(x) quantile(ms$theta[,x[1],x[2]], probs=probs)))
d_qua <- data.frame(idx, d_qua)
colnames(d_qua) <- c('document', 'topic', paste0('p', probs*100))
for (i in 1:25){
  p <- ggplot(data=subset(d_qua, document %in% c(n:(n+1))), aes(x=topic, y=p50))
  n <- n + 2
  p <- p + theme_bw(base_size=18)
  p <- p + facet_wrap(~document, nrow=2)
  p <- p + coord_flip()
  p <- p + scale_x_reverse(breaks=1:6)
  p <- p + geom_bar(stat='identity')
  p <- p + geom_errorbar(aes(ymin=p25, ymax=p75), width=0.25)
  p <- p + labs(x='topic', y='theta[n,k]')
  p <- p + theme(axis.text.y = element_text(angle = 90, hjust = 1))
  ggsave(file=paste('bLDA','/bLDA_theta',as.character(i),'.png',sep=""), plot=p, dpi=300, w=5, h=5)
  }