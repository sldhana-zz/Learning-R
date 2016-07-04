# Write a function called rankall that takes two arguments: an outcome name
# (outcome) and a hospital ranking (num). The function reads the
# outcome-of-care-measures.csv file and returns a 2-column data frame containing
# the hospital in each state that has the ranking specified in num. For example
# the function call rankall("heart attack", "best") would return a data frame
# containing the names of the hospitals that are the best in their respective
# states for 30-day heart attack death rates. The function should return a value
# for every state (some may be NA). The first column in the data frame is named
# hospital, which contains the hospital name, and the second column is named
# state, which contains the 2-character abbreviation for the state name.
# Hospitals that do not have data on a particular outcome should be excluded
# from the set of hospitals when deciding the rankings. Handling ties. The
# rankall function should handle ties in the 30-day mortality rates in the same
# way that the rankhospital function handles ties.

library(plyr)

readData<- function(directory, filename){
  setwd("/home/sldhana/Learning/R/Week 4")
  setwd(file.path(getwd(), directory))
  outcome <- read.csv(filename, header=TRUE, na.strings=c("Not Available", "NA"), colClasses = "character")
}

rankall <- function(outcome, num="best") {
  data <- readData("ProgAssignment3-data", "outcome-of-care-measures.csv")
  match = ''
  all_states <- sort(unique(data$State))
  
  if(outcome == 'heart attack'){
    match = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack'
  }
  else if(outcome == 'heart failure'){
    match = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure'
  }
  else if(outcome == 'pneumonia'){
    match = 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia'
  }
  
  # check data validity
  if(!match %in% colnames(data)){
    stop("invalid outcome")
  }
  
  # now, only get the hospital name and the column we need
  sliced <- data[, c('Hospital.Name', 'State',  match)]

  # check if we get data for the match
  if(nrow(sliced) == 0){
    stop("invalid outcome") 
  }
  
  # remove all NA data
  sliced <- subset(sliced, !is.na(sliced[match]))
  
  # cast the match column to numeric
  sliced[,3] <- as.numeric(sliced[, 3])
  
  
  
  if(num == "best"){
    ordered <- get_best_ranks(all_states, sliced, match)
  }
  else if(num == "worst"){
    ordered <- get_worst_ranks(all_states, sliced, match)
  }
  
  else if(is.numeric(num)){
    ordered <- get_numeric_rank(all_states, sliced, match, num)
  }
  else{
    NA
  }
  
  # ordered <- ddply(ordered, 'State', function(x){
  #   if(num == "best"){
  #     x[x[match] == min(x[match]), ][1, ]
  #   }
  #   else if(num == "worst"){
  #     x[x[match] == max(x[match]), ][1]
  #   }
  #   
  # })
  
  print(ordered)
}

get_best_ranks <- function(all_states, data, match){
  data <- ddply(data, 'State', function(x){
    x[x[match] == min(x[match]), ]
  })
  
  # need to sort first based on name to remove duplicate ranks
  sort_by <- c('State', 'Hospital.Name')
  data <- data[do.call("order", data[sort_by]), ]
  
  data <- ddply(data, 'State', function(x){
    x[1, ]
  })
  
  # order data by rank, state and hospital name
  sort_by <- c('State', 'Hospital.Name', match)
  ordered <- data[do.call("order", data[sort_by]), ]
  ordered <- setNames(ordered, c("hospital", "state", "rank"))
}

get_worst_ranks <- function(all_states, data, match){
  data <- ddply(data, 'State', function(x){
    x[x[match] == max(x[match]), ]
  })
  
  data <- ddply(data, 'State', function(x){
    x[1, ]
  })
  
  # order data by rank, state and hospital name
  sort_by <- c('State', 'Hospital.Name', match)
  ordered <- data[do.call("order", data[sort_by]), ]
  ordered <- setNames(ordered, c("hospital", "state", "rank"))
}

get_numeric_rank <- function(all_states, data, match, position){
  # order data by rank, state and hospital name
  sort_by <- c('State', match, 'Hospital.Name')
  data <- data[do.call("order", data[sort_by]), ]

  data <- ddply(data, 'State', function(x){
    x[position, ]
  })
  
  # change the column names
  data <- setNames(data, c("hospital", "state", "rank"))
}
