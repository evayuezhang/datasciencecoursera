
# The cachematrix.R contains two functions:
# makeCacheMatrix and cacheSolve, 
# were designed to store a matrix and its inverse in cache
# and return cached values when needed


# makeCacheMatrix: this function creates a matrix object
# and its inverse
makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        set <- function(y){
                x<<-y
                i<<-NULL
        }
        get <- function()x
        setinverse <- function(inverse) i<<-inverse
        getinverse <- function()i
        list(set=set,get=get,
             setinverse=setinverse,
             getinverse=getinverse)
        
}

# cacheSolve: this function requires an argument
# that is returned by makeCacheMatrix in order to
# retrieve the inverse from the cached values
# that stored in makeCacheMatrix object's environment

cacheSolve <- function(x, ...) {
        i <- x$getinverse()
        print(i)
        if(!is.null(i)){
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data,...)
        x$setinverse(i)
        m
        ## Return a matrix that is the inverse of 'x'
}

bMatrix <- makeCacheMatrix(matrix(c(1,6,1,2),nrow=2, ncol=2))
bMatrix$get()
bMatrix$getinverse()
cacheSolve(bMatrix)

# Reference:
# https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-breakingDownMakeVector.md
 
# expamples from the assignment instruction
makeVector <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}

cachemean <- function(x, ...) {
        m <- x$getmean()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...) #only line to calculate the mean
        x$setmean(m)
        m
}


aVector <- makeVector(1:10)
aVector$get()
aVector$getmean()
aVector$set(30:50)
cachemean(aVector)









