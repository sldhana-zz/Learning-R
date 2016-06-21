# Write a function that reads a directory full of files and reports the number
# of completely observed cases in each data file. The function should return a
# data frame where the first column is the name of the file and the second
# column is the number of complete cases. A prototype of this function follows

# source("complete.R")
# complete("specdata", 1)
# ##   id nobs
# ## 1  1  117
# complete("specdata", c(2, 4, 8, 10, 12))
# ##   id nobs
# ## 1  2 1041
# ## 2  4  474
# ## 3  8  192
# ## 4 10  148
# ## 5 12   96
# complete("specdata", 30:25)
# ##   id nobs
# ## 1 30  932
# ## 2 29  711
# ## 3 28  475
# ## 4 27  338
# ## 5 26  586
# ## 6 25  463
# complete("specdata", 3)
# ##   id nobs
# ## 1  3  243

complete <- function(directory="specdata", range){
  # set the current directory
  setwd("..")
  setwd(file.path(getwd(), directory))
  
  # rows containing valid data and current total
  rows <- 0
  # dataframe that will contain completes
  res <- NULL
  
  for (i in range){
    # use the paste function to preformat with 001, 010, etc
    fileName <- paste(formatC(i, width=3, flag="0"), "csv", sep=".")
    data <- read.csv(fileName, header=TRUE, na.strings="NA")
    
    #get rid of NA data
    data <- na.omit(data)
    
    #get total valid observations
    rows <- nrow(data)
    
    # append rows
    res <- rbind(res, c(i, rows))
  }
  
  #convert to dataframe
  res <- data.frame(res)
  names(res) <- c("id", "nobs")
  return(res)
}

