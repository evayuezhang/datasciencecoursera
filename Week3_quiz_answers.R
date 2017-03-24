library(datasets)
data(iris)
?iris

#Q1
head(iris)
tapply(iris$Sepal.Length,iris$Species,mean)

#Q2
#right ways:
class(iris)
apply(iris[,1:4],2,mean) #works
colMeans(iris[,1:4]) #works

#wrong ways:
lapply(iris,mean) #warning:mean of Species is NA
colMeans(iris) #error, x must be numeric
apply(iris,2,mean) #warning, returning 5 NAs

#Q3
data(mtcars) #motor trend car road tests
?mtcars
head(mtcars)
#right ways:
tapply(mtcars$mpg,mtcars$cyl,mean)
sapply(split(mtcars$mpg,mtcars$cyl),mean) #only keep mpg&cyl in a list
with(mtcars,tapply(mpg,cyl,mean)) #with(data,expression,...)
?with

#wrong ways:
mean(mtcars$mpg,mtcars$cyl)
sapply(mtcars,cyl,mean)
lapply(mtcars,mean)
apply(mtcars,2,mean)

#Q4
hp_cyl <- tapply(mtcars$hp,mtcars$cyl,mean)
hp_cyl
abs(hp_cyl[1]-hp_cyl[3])

#Q5
debug(ls)
ls
ls()
Q #to quit debugging mode

