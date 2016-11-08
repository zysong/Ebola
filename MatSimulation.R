K<-matrix(c(.9, .1, 0, .1, .5, .1, 0, .1, 2), nrow=3)
I0<-c(10, 0, 0)
step<-10
I<-matrix(rep(0, (step+1)*3), ncol = 3)
I[1,]<-I0

for (t in 1:step){
  I[t+1,]<-rpois(3, K%*%I[t,])
}

matplot(I, type = "l")
