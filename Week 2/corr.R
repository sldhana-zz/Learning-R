# Write a function that takes a directory of data files and a threshold for
# complete cases and calculates the correlation between sulfate and nitrate for
# monitor locations where the number of completely observed cases (on all
# variables) is greater than the threshold. The function should return a vector
# of correlations for the monitors that meet the threshold requirement. If no
# monitors meet the threshold requirement, then the function should return a
# numeric vector of length 0. A prototype of this function follows

# source("corr.R")
# source("complete.R")
# cr <- corr("specdata", 150)
# head(cr)
# ## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
# cr <- corr("specdata", 400)
# head(cr)
# ## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
# cr <- corr("specdata", 5000)
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## 
# length(cr)
# ## [1] 0
# cr <- corr("specdata")
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
# length(cr)
# ## [1] 323

corr <- function(directory="specdata", threshold=0){
  # set the current directory
  setwd("..")
  setwd(file.path(getwd(), directory))
  
  #empty vector
  res <- vector(mode="numeric", length=0)
  # dataframe that will contain completes
  res <- NULL
  
  for (i in 1:332){
    # use the paste function to preformat with 001, 010, etc
    fileName <- paste(formatC(i, width=3, flag="0"), "csv", sep=".")
    data <- read.csv(fileName, header=TRUE, na.strings="NA")
    
    #get rid of NA data
    data <- na.omit(data)
    if(nrow(data) > threshold){
      correlation <- cor(data$sulfate, data$nitrate)
      res <- c(res, correlation)
    }
  }
  return(res)
}

