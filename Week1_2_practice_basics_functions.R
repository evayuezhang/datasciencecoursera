#1. Basic Building Blocks
install.packages("swirl")
packageVersion("swirl")
library(swirl)
install_from_swirl("R Programming") #not necessary
swirl()

#to fix:Error in curl::curl_fetch_memory
#source: https://github.com/swirldev/swirl/issues/475
library(bitops)
library(RCurl)
library(httr)
set_config( config( ssl_verifypeer = 0L ) )

#clean the enviroment
ls()
rm(list=ls())

help.start()
z<-c(1.1,9,3.14) #create a vector
?c
sqrt(z)
c(1,2,3,4)+c(0,10) #result: 1,12,3,14

#2. Workspace and Files
?list.files
list.files() 
dir()
args(list.files) 
#see what arguments a function can take
old.dir <- getwd()
dir.create("testdir")
lis.files()
setwd("testdir")
file.create("mytext.R")
file.exists("mytest.R")
file.info("mytest.R")
file.rename("mytest.R","mytest2.R")
file.copy("mytest2.R","mytest3.R")
file.path("mytest3.R")
file.path("folder1","folder2")

#create a nested directory: testdir2/testdir3
dir.create(file.path('testdir2','testdir3'),recursive=TRUE)
setwd(old.dir)

#3. Sequences of Numbers
pi:10
?':'
seq(0,10,0.5)
my_seq <- seq(5,10,length=30)
length(my_seq)
1:length(my_seq)
seq(along.with=my_seq)
seq_along(my_seq)
rep(0,times=40)
rep(c(0,1,2),times=10)
rep(c(0,1,2),each=10)

#4.Vectors
num_vect <- c(0.5,55,-10,6)
tf <- num_vect<1 
#tf is a vector of 4 logical values
my_char<- c("My","name","is")
paste(my_char,collapse = " ") 
#integrate all elements
my_name <- c(my_char,"eva")
paste(my_name,collapse = " ")
paste("Hello","world!",sep=" ")
paste(1:3,c("X","Y","Z"),sep="")
paste(LETTERS,1:4,sep="-") 
#interesting vector recycling

#5.Missing Values
y <- rnorm(1000) 
#create a vector contaning 1000 draws 
#from a standard normal distribution
my_data <- sample(c(y,z),100)
#sampling the y and z for 100 elements
my_na <- is.na(my_data)
my_data==NA 
#the logical expression is incomplete so all NAs
sum(my_na)
0/0 #NaN,not a number
Inf-Inf #NaN

#6.Subsetting Vectors
x
x[1:10]
#logical vectors, vectors of positive integers,
#vectors of negative integers,vectors of character string
x[is.na(x)] 
#a vector of all NAs
y <- x[!is.na(x)]
y[y > 0] 
# resuilt if a vector of all the positive elements of y
x[!is.na(x) & x>0]
x[c(3,5,7)] 
#get 3rd,5th,and 7th elements of x
x[0] #numberic(0)
x[3000] #NA
x[c(-2,-10)] 
#all elements except 2nd and 10th
x[-c(2,10)] #same as the above
vect <- c(foo = 11, bar = 2, norf = NA)
names(vect) #vector's names
vect2 <- c(11,2,NA)
names(vect2) <- c("foo", "bar","norf")
identical(vect,vect2) #True

#7.Matrices and Data Frames
my_vector <- 1:20
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4,5) 
#give the vector a dimension attribute
dim(my_vector)
attributes(my_vector)
my_matrix <- my_vector
my_matrix2 <- matrix(1:20,4,5)
patients <- c("Bill","Gina","Kelly","Sean")
cbind(patients,my_matrix)
#combine colums, the first col are names, matrix becomes characters
#matrix only contains one type of data, so this is
#implicit coercion
my_data <- data.frame(patients,my_matrix)
my_data
cnames <- c("patient","age","weight","bp","rating","test")
colnames(my_data) <- cnames
#set the colnames attribute to the data frame

#8.Logic
# & evaluate aross a vecotr
# && only evaluates the 1st number of a vetor
isTRUE(6>4)
identical("twins","twins")
xor(5==6,!FALSE)

ints <- sample(10)
ints
ints>5 
#logical vector
which(ints>7) 
#treturns the indices of the vestor that are true
any(ints<0)
all(ints>0)

#9.Functions
Sys.Date()
mean(c(2,4,5))






