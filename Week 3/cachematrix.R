# The methods are are to figure out the inverse of a matrix.  Since
# it is computationally intensive, cache the values

makeCacheMatrix <- function(x=matrix()){
  # x is a square invertible matrix.  This function returns a list of functions.
  # The functions contain sub functions to set the matrix, get the matrix,
  # set the inverse and return the inverse.
  cached <- NULL
  
  # setting value to cache
  set <- function(y) {
    # using the super assignment operator allows the subfunctions to modify the objects
    # that is in the parent scope (different from current environment)
    x <<- y
    cached <<- NULL
  }
  
  get <- function() x
  
  setinverse <- function(inv) cached <<- inv
  
  getinverse <- function() cached
  
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

cacheSolve <- function(x, ...){
  # Returns the inverse of the original matrix input -x
  
  # check if it is cached
  inv <- x$getinverse()
  
  # the result is not null, already computed, so return
  if(!is.null(inv)) {
    message("getting cached matrix")
    return(inv)
  }
  
  # the matrix was not cached, so we get what was stored.
  data <- x$get()
  # we call the inverse function
  inv <- solve(data, ...)
  # store it
  x$setinverse(inv)
  # return it
  inv
}

test <- function(mat){
  start.time = Sys.time()
  cacheSolve(mat)
  dur = Sys.time() - start.time
  print(dur)
  
  start.time = Sys.time()
  cacheSolve(mat)
  dur = Sys.time() - start.time
  print(dur)
}

set.seed(100)
r <- rnorm(1000000)
mat <- matrix(r, nrow=1000, ncol=1000)
mat1 <- makeCacheMatrix(mat)
test(mat1)