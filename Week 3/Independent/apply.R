library(ggplot2)
library(plyr)
setwd("/home/sldhana/Learning/R/Week 3/Independent")
bnames <- read.csv("bnames2.csv.bz2")

# get gregs
greg <- subset(bnames, name=="Greg")

#plot the popularity of greg

qplot(x=year, y=prop, data=greg, geom="line")

#plot the popularity of name michelle by gender
michelle <- subset(bnames, name=="Michelle")
qplot(x=year, y=prop, data=michelle, geom="line", group=sex)

# Repeat the same exercises we did for name with the variable soundex. In other
# words, use the soundex variable to extract all names that sound like yours and
# plot their popularity. Make sure to think about the geom you would like to
# use!
dhana <- subset(bnames, name=="Donna")
dhana_soundex <- dhana$soundex
dhana_like <- subset(bnames, soundex==dhana_soundex)
qplot(x=year, y=prop, data=dhana_like, geom="point")

setwd("/home/sldhana/Learning/R/Week 3/Independent")
births <- read.csv("births.csv")

#Suppose, we want to explore trends in the total number of people with a
#specific name across all the years. The bnames2 dataset only has proportions.
#So, to be able to address this question, we need total number of births by
#year.
qplot(x=year, y=births, data=births, color=sex, geom="line")

#Going back to the question we were trying to address, we need a way to join the
#births data with bnames2 so that we can compute total numbers. Base R has the
#merge function to achieve this. But, I am partial to the join function in plyr,
#and so we shall use that.
bnames_2<- join(bnames, births, by=c("sex", "year"))

greg <- subset(bnames_2, name=="Greg")
greg <- mutate(greg, tot=prop * births)
qplot(x=year, y=tot, data=greg, geom="line")


#first lappy
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
#split names
split_math <- strsplit(pioneers, split=":")
#convert to lowercase
split_low <- lapply(split_math, tolower)

#lapply with your own function
select_first <- function(x){
  x[1]
}
names <- lapply(split_low, select_first)


#lapply with annonymous function
names <- lapply(split_low, function (x){x[1]})

#lapply with arguments
multiply <- function(x, factor){
  x*factor
}

res <- lapply(list(1,2,3), multiply, factor=3)

#sapply
d1 <- c(3, 7, 9, 6, -1)
d2 <- c(6, 9, 12, 13, 5)
d3 <- c(4, 8, 3, -1, -3)
d4 <- c(1, 4, 7, 2, -2)
d5 <- c(5, 7, 9, 4, 2)
d6 <- c(-3, 5, 8, 9, 4)
d7 <- c(3, 6, 9, 4, 1)
temp =list(d1,d2,d3,d4,d5,d6,d7)
# Use sapply() to find each day's minimum temperature
lapply(temp, min)
sapply(temp, min)

# Use sapply() to find each day's max temperature
sapply(temp, max)

#sapply with your own function
extremes_avg <- function(x){
  (min(x) + max(x))/2
}

sapply(temp, extremes_avg)

#sapply with vector being returned as min and max
extremes <- function(x){
  c(min=min(x), max=max(x))
}

sapply(temp, extremes)

#when sapply cannnot simplify
below_zero <- function(x){
  return (x[x<0])
}

freezing <- sapply(temp, below_zero)

#sapply with functions that return NULL
print_info <- function(x) {
  cat("The average temperature is", mean(x), "\n")
}

# Apply print_info() over temp using lapply()
sapply(temp, print_info)

#vapply - a more robust version of sapply
# Function that takes a vector, and returns a named vector of length three, 
# containing the minimum, mean and maximum value of the vector respectively. 

basics <- function(x){
  c(min=min(x), max=max(x), mean=mean(x))
}
vapply(temp, basics, numeric(3))

# If we use 2 instead of 3, it throws an error
vapply(temp, basics, numeric(2))