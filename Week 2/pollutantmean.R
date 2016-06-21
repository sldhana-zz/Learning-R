# Write a function named 'pollutantmean' that calculates the mean of a pollutant
# (sulfate or nitrate) across a specified list of monitors. The function
# 'pollutantmean' takes three arguments:'directory', 'pollutant', and 'id'.
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors'
# particulate matter data from the directory specified in the 'directory'
# argument and returns the mean of the pollutant across all of the monitors,
# ignoring any missing values coded as NA. A prototype of the function is as
# follows


# source("pollutantmean.R")
# pollutantmean("specdata", "sulfate", 1:10)
# ## [1] 4.064
# pollutantmean("specdata", "nitrate", 70:72)
# ## [1] 1.706
# pollutantmean("specdata", "nitrate", 23)
# ## [1] 1.281

pollutantmean <- function(directory="specdata", pollutant, range=1:332){
  # set the current directory
  setwd("..")
  setwd(file.path(getwd(), directory))
  
  # rows containing valid data and current total
  rows = 0
  pollutantTotal = 0
  
  #setwd(setwd(paste(getwd(), directory, sep="/")))
  for (i in range){
    # use the paste function to preformat with 001, 010, etc
    fileName <- paste(formatC(i, width=3, flag="0"), "csv", sep=".")
    data <- read.csv(fileName, header=TRUE, na.strings="NA")
    
    #get rid of NA data
    data <- na.omit(data)
    
    #get total valid observations
    rows <- rows + nrow(data)
    
    #get sum
    pollutantTotal <- pollutantTotal + sum(data[, pollutant])
  }
  res <- (pollutantTotal/rows)
  return(res)
}

