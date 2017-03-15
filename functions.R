add2 <- function(x,y){
  x+y
}

above10 <- function(x){
  use <- x>10 #logical vector
  x[use]
}

above <- function(x,n=10){ #default value
  use <- x>n #cut value
  x[use]
}


columnmean <- function(y, removeNA=TRUE){ #exclude all the NAs
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(y[,i],na.rm=removeNA)
  }
  means #call means
}

#argument matching

#function structure
args(lm)
args(paste)
paste("a","b",sep=":")

#scoping rules
#binding values to symbol
search()
#lexical scoping
f<-function(x,y){
  x^2+y/z
}
#z is a free variable, not a local variable

#Maximizing a normal likelihood
ls



