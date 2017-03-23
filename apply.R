#The Flags dataset from the UCI Machine Learning Repository

#10: lapply and sapply
head(flags)
dim(flags)
viewinfo(flags) #open a complete description of the dataset in a text file

class(flags)
cls_list <- lapply(flags,class) #l represents list
cls_list
class(cls_list)
as.character(cls_list) #change the list to a character vector
cls_vect <- sapply(flags,class)
class(cls_vect)

sum(flags$orange)
flag_colors <- flags[,11:17]
head(flag_colors)
lapply(flag_colors,sum)
sapply(flag_colors,sum)
sapply(flag_colors,mean)
flag_shapes <- flags[,19:23]
lapply(flag_shapes,range)
shape_mat <- sapply(flag_shapes,range)
shape_mat
class(shape_mat)

unique(c(3,4,5,5,5,6,6))
unique_vals <- lapply(flags,unique)
sapply(unique_vals,length) #the nubmer of the unique values for each variables
sapply(flags,unique) #unsimplified list
lapply(unique_vals,function(elem) elem[2]) #anonymous functions
# return a list containing the 2nd item from each element of the list

#11: vapply and tapply (Split-Apply-Combine)
#vapply specifies format of the result, otherwise returns a error
vapply(flags,unique,numeric(1)) #result to be a numeric vecotr of lenght 1
ok()
sapply(flags,class) #get a character vector of column classes
vapply(flags,class,character(1))

#tapply splitsthe data into groups
table(flags$landmass) #see how many flags fall into each group
table(flags$animate)
tapply(flags$animate,flags$landmass,mean) 
#how many animated elements in each landmass
tapply(flags$population,flags$red,summary)
#a summary of population for 'red' country, unit: millions!
tapply(flags$population,flags$red,summary)

























