# Author: Eva_Y_Zhang
# Update: 3/9/2017
# R Version: 3.3.3

# install R pacadge-tidyverse
# dplyr in tidyverse is the pacadge to use later
install.packages("tidyverse")
library("tidyverse")

# download hw1_data.zip, unzipped and open the csv file in RStudio
eva <- read.csv("hw1_data.csv")

ozone <- eva[,1]
solar<- eva[,2]
temp <- eva[,4]
month <- eva[,5]

# quiz question 1: 
# what is the mean of Solar.R while Ozone>31 & Temp>90s?
eva_solar <- filter(eva,ozone>31,temp>90)
solar_mean <- mean(eva_solar[,2]) 
#solar_mean = 212.8

# quiz question 2: 
# what is the mean of Temp while month is 6?
eva_temp <- filter(eva,month==6)
temp_mean <- mean(eva_temp[,4])

#Week 2 Quiz
cube <- function(x,n){
        x^3
}
cube(3)

x <- 1:10
if(x>5){
        x<0
}

f <- function(x){
        g <- function(y){
                y+z
        }
        z <- 4
        x+g(x)
}
z <- 10
f(3)

x <- 5
y <- if(x < 3) {
        NA
} else {
        10
}
y


