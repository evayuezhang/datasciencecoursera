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

#lexical scoping
make.power <- function(n){
        pow <- function(x){
                x^n
        }
        pow
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

#exploring a function closure
ls(environment(cube))
get("n",environment(cube))
ls(environment(square))
get("n",environment(square))

#lexical vs dynamic scoping
y <- 10
f <- function(x){ #calling environment/parent frame
        y <- 2
        y^2+g(x)
}
y #10

g<- function(x){
        x*y
}
f(3) #34


g <- function(x){
        a <- 3
        x+a+y
}
g(2)

y <- 3
g(2)

#Dates and Time
#dates use the date class
#times use the POSIXct and POSIXlt class
x <- as.Date("1970-01-01")
x
unclass(x) #interanlly as 0 day
unclass(as.Date("1970-01-02"))

#a very large integer under the hood
x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
unclass(x)
x$sec
p <- as.POSIXlt(x)
p$sec

datestring <- c("March 19, 2017 11:33", "April 17, 1987 11:00")
x <- strptime(datestring,"%B %d,%Y %H:%M")
x
class(x) #check ?strptime for deatils

x <- as.Date("2017-01-01")
x <- as.POSIXct(x)
x
y <- strptime("9 Jan 2015 11:34:21","%d %b %Y %H:%M:%S")
y
x-y
class(x)

#tz="GMT", specify the time zone

# By default, Sys.time() returns an object of class POSIXct
#but we can coerce the result to POSIXlt with as.POSIXlt(Sys.time()). 
#all POSIXlt objects are just a list of values that make up the date and time. 
#Use str(unclass()) to have a more compact view.

#What if we need to reference a date prior to 1970-01-01? 
d2 <- as.Date("1969-01-01")
unclass(d2) #-365
difftime(Sys.time(),t1,units='days')

#Looping
#1.lapply
x <- list(a=1:5,b=rnorm(10))
x
lapply(x,mean)
x <- list(a=1:4,b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
x
lapply(x,mean)
x <- 1:4
lapply(x,runif) #generates a uniform random variable
lapply(x,runif,min=0,max=10)
x <- list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
x
lapply(x,function(elt) elt[,1])
sapply

#2.apply
#calculate the column mean
x <- matrix(rnorm(200),20,10)
apply(x,2,mean) #colMeans in matrix
apply(x,1,sum) #rowSums
#calculate quantiles of the rows
apply(x,1,quantile,probs=c(0.25,0.75))

a <- array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2),mean) #keep the 1st and 2nd dimensions
rowMeans(a,dims=2) #the same as above

list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
mapply(rep,1:4,4:1) #simply the above

#2. mapply
noise <- function(n,mean,sd){
        rnorm(n,mean,sd)
}
noise(5,1,2)#mean is 1, sd is 2
#generate 5 vectors with means from 1-5, sd=2
noise(1:5,1:5,2) #wrong
mapply(noise, 1:5,1:5,2) #correct

#3. tapply
x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10) #generate factor levels
f
tapply(x,f,mean) #f is a list of factors
tapply(x,f,mean,simplify=FALSE)
tapply(x,f,range)

#4. split
split(x,f) #return a list
lapply(split(x,f),mean)

library(datasets)
head(airquality)
s <- split(airquality,airquality$Month)
s
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
#function(x) is anonomous function
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm="TRUE"))

#splitting on more than 1 level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1,f2) #combine two levels
str(split(x,list(f1,f2),drop=T)) #drop empty levels

#Debugging
printmessage <- function(x){
        if(is.na(x))
                print("x is a missing value")
        else if(x>0)
                print("x is greater than zero")
        else 
                print("x is less than or equal to zero")
        invisible(x) #doesn't print in the console
}
printmessage(1)
printmessage(NA)
#got a error-it doesn't know what to do
x <- log(-1)
printmessage(x)

mean(aaa)
traceback()
lm(yyy-xxx)
traceback()
debug(lm)
lm(yyy-xxx)

options(error=recover) #set up global recover
read.csv("nosuchfile")
options(error=NULL)



