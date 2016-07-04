# Write a function called rankhospital that takes three arguments: the
# 2-character abbreviated name of a state (state), an outcome (outcome), and the
# ranking of a hospital in that state for that outcome (num). The function reads
# the outcome-of-care-measures.csv file and returns a character vector with the
# name of the hospital that has the ranking specified by the num argument. For
# example, the call rankhospital("MD", "heart failure", 5) would return a
# character vector containing the name of the hospital with the 5th lowest
# 30-day death rate for heart failure. The num argument can take values “best”,
# “worst”, or an integer indicating the ranking (smaller numbers are better). If
# the number given by num is larger than the number of hospitals in that state,
# then the function should return NA. Hospitals that do not have data on a
# particular outcome should be excluded from the set of hospitals when deciding
# the rankings. Handling ties. It may occur that multiple hospitals have the
# same 30-day mortality rate for a given cause of death. In those cases ties
# should be broken by using the hospital name. For example, in Texas (“TX”), the
# hospitals with lowest 30-day mortality rate for heart failure are shown here.

readData<- function(directory, filename){
  setwd("/home/sldhana/Learning/R/Week 4")
  setwd(file.path(getwd(), directory))
  outcome <- read.csv(filename, header=TRUE, na.strings=c("Not Available", "NA"), colClasses = "character")
}

rankhospital <- function(state, outcome, num="best") {
  data <- readData("ProgAssignment3-data", "outcome-of-care-measures.csv")
  match = ''
  
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
  
  # filter by state first
  sliced <- subset(data, State==state)
  
  # if result of state is 0, it's not a valid state
  if(nrow(sliced) == 0){
    stop("invalid state") 
  }
  
  # now, only get the hospital ntame and the column we need
  sliced <- sliced[, c('Hospital.Name', match)]
  
  # check if we get data for the match
  if(nrow(sliced) == 0){
    stop("invalid outcome") 
  }
  
  # remove all NA data
  sliced <- subset(sliced, !is.na(sliced[match]))
  
  # cast the match column to numeric
  sliced[,2] = as.numeric(sliced[, 2])
  
  # use order to sort the data based on match variable
  sort_by <- c(match, 'Hospital.Name')
  
  # order the data
  ordered <- sliced[do.call("order", sliced[sort_by]), ]
  
  # check num type first to figure out return type
  if(num == "best"){
    ordered[1, 1]
  }
  else if(num == "worst"){
    tail(ordered, 1)[1, 1]
  }
  else if(is.numeric(num) && nrow(ordered) >= num){
    ordered[num, 1]
  }
  else{
    NA
  }
}