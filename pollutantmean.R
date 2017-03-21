#C:\Users\zy_mo\Dropbox\Programming\specdata

path <- "C:/Users/zy_mo/Dropbox/Programming"
setwd(path)
directory <- "specdata"

#Part 1
pollutantmean <- function(directory,pollutant,id=1:332){
        total_sum=0
        total_count=0
        for(i in id){
                if (i<10){
                        p <- paste(directory,"/","00",i,".csv",sep="")
                }else if(i<100 & i>9){
                        p <- paste(directory,"/","0",i,".csv",sep="")
                }else if(i>99 & i<333){
                        p <- paste(directory,"/",i,".csv",sep="")
                }
                my_data <- read.csv(p)
                #View(my_data)
                my_pollu <- my_data[pollutant]
                #View(my_pollu)
                
                Na_count <- !is.na(my_pollu)
                #View(Na_count)
                my_pollu_new <- my_pollu[Na_count]
                #View(my_pollu_new)
                
                pollu_sum <- sum(my_pollu_new)
                #View(pollu_sum)
                total_sum <- total_sum+pollu_sum  
                #View(total_sum)
                
                pollu_count <- length(my_pollu_new)
                if (pollu_count==0){
                        if(length(id)==1){
                                stop("The values in this column are missing!")
                                
                        }else{
                                total_count <- total_count+pollu_count
                        }
                }else{
                        total_count <- total_count+pollu_count
                }
                #View(pollu_count)
        }
        View(total_sum)
        View(total_count)
        total_mean<- total_sum/total_count
        total_mean
}
pollutantmean("specdata","sulfate",1:10)
pollutantmean("specdata","nitrate",70:72)
pollutantmean("specdata","sulfate",34)
pollutantmean("specdata","nitrate")

#Part 2
complete <- function(directory,id=1:332){
        count_col <- 0
        count_id <- 0
        for(i in id){
                if (i<10){
                        p <- paste(directory,"/","00",i,".csv",sep="")
                }else if(i<100 & i>9){
                        p <- paste(directory,"/","0",i,".csv",sep="")
                }else if(i>99 & i<333){
                        p <- paste(directory,"/",i,".csv",sep="")
                }
                my_data <- read.csv(p)
                #View(my_data)
                nit <- my_data["nitrate"]
                sul <- my_data["sulfate"]
                #View(nit)
                #View(sul)
                
                nit_count <- !is.na(nit)
                sul_count <- !is.na(sul)
                comp_count <- nit_count*sul_count
                #View(comp_count)
                nit_new <- nit[comp_count==1]
                sul_new <- sul[comp_count==1]
                #View(nit_new)
                #View(sul_new)
                
                count <- length(nit_new)
                if (count!="NA"){
                        count_col[i] <- count
                        count_id[i] <- i    
                }
            
        }
        my_data_frame <- data.frame(count_id,count_col)
        cnames<- c("ID","nobs")
        colnames(my_data_frame) <- cnames
        View(my_data_frame)
}
#?data.frame
a <- complete("specdata",278)
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
View(use)
print(cc[use, "nobs"])

#Part 3
?cor
corr <- function(directory,threshold=0){
        count_table <- 0
        correlation <- 0
        #count_col <- vector(mode="numeric", length=0)
        
        #read csv files
        for(i in 1:332){
                if (i<10){
                        p <- paste(directory,"/","00",i,".csv",sep="")
                }else if(i<100 & i>9){
                        p <- paste(directory,"/","0",i,".csv",sep="")
                }else if(i>99 & i<333){
                        p <- paste(directory,"/",i,".csv",sep="")
                }
                my_data <- read.csv(p)
                #View(my_data)
                
                nit <- my_data["nitrate"]
                sul <- my_data["sulfate"]
                #View(nit)
                
                nit_count <- !is.na(nit)
                sul_count <- !is.na(sul)
                comp_count <- nit_count*sul_count
             
                nit_new <- nit[comp_count==1]
                sul_new <- sul[comp_count==1]
                #View(nit_new)
                #View(nit_new)
                        
                count <- length(nit_new)
                #print(count)
               
                if(count>threshold){
                        count_table[i] <- count
                        correlation[i] <- cor(nit_new,sul_new,use="complete.obs",method="pearson")
                        #print(correlation[i])
                }
        }
        return(correlation)
        #my_data_frame <- data.frame(correlation)
        #na.omit(my_data_frame)
        #cnames<- c("count","correlation")
        #colnames(my_data_frame) <- cnames
}

cr <- corr("specdata")
View(cr)
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))







#Test 1 for initial structure
####################################################################
#source("C:/Users/zy_mo/Dropbox/Programming/specdata/001.csv")

#initial <- read.csv("specdata/001.csv")

#init_sul <- inital["sulfate"]
#init_sul

#sul_sum=sum(init_sul,na.rm=TRUE)
#sul_sum

#NA_count <- !is.na(init_sul)
#NA_count
#init_sulnew <- init_sul[NA_count]
#init_sulnew

#sul_count <- length(init_sulnew)
#sul_count

#sul_mean <- sul_sum/sul_count
#sul_mean

#Test 2 for finding missing values
#####################################################################
# test_total_count <- 0
# 
# test_pollu <- read.csv("specdata/278.csv")
# test_pollu
# test_pollu_col <- test_pollu["nitrate"]
# test_pollu_col
# 
# Na_count <- !is.na(test_pollu_col)
# Na_count
# test_pollu_new <-test_pollu_col[Na_count]
# test_pollu_new
# test_sum <- sum(test_pollu_new)
# test_sum
# test_total_count <- test_total_count+test_sum
# test_count <- length(test_pollu_new)
# test_count
# test_total_count=test_total_count+test_count
# test_total_count
# test_mean=test_sum/test_count
# test_mean


#Test 3 for existing the loop while all values are missing
#####################################################################
# id=1:1
# length(id)
# if (length(id)==1){
#         stop(" ")
# }