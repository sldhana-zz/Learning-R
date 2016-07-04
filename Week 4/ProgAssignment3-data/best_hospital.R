# Write a function called best that take two arguments: the 2-character
# abbreviated name of a state and an outcome name. The function reads the
# outcome-of-care-measures.csv file and returns a character vector with the name
# of the hospital that has the best (i.e. lowest) 30-day mortality for the
# specified outcome in that state. The hospital name is the name provided in the
# Hospital.Name variable. The outcomes can be one of “heart attack”, “heart
# failure”, or “pneumonia”. Hospitals that do not have data on a particular 
# outcome should be excluded from the set of hospitals when deciding the
# rankings. Handling ties. If there is a tie for the best hospital for a given
# outcome, then the hospital names should be sorted in alphabetical order and
# the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”, 
# and “f” are tied for best, then hospital “b” should be returned).

readData<- function(directory, filename){
  setwd("/home/sldhana/Learning/R/Week 4")
  setwd(file.path(getwd(), directory))
  outcome <- read.csv(filename, header=TRUE, na.strings=c("Not Available", "NA"), colClasses = "character")
}

best <- function(state, outcome) {
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
    stop("invalid outcome") 
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
  # return first row, first column
  ordered[1, 1]
}