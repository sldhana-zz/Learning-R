#If I execute the expression x <- 4L in R, what is the class of the object `x' as determined by the `class()' function?
integer

#What is the class of the object defined by x <- c(4, TRUE)?
numeric

#If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced by the expression cbind(x, y)?
a matrix with 2 columns and 3 rows

#A key property of vectors in R is that
elements of a vector all must be of the same class

#Suppose I have a list defined as x <- list(2, "a", "b", TRUE). What does x[[1]] give me? Select all that apply.
a numeric vector containing the element 2.
a numeric vector of length 1.

#Suppose I have a vector x <- 1:4 and a vector y <- 2. What is produced by the expression x + y?
a numeric vector with elements 3, 4, 5, 6.

#Suppose I have a vector x <- c(17, 14, 4, 5, 13, 12, 10) and I want to set all elements of this vector that are greater than 10 to be equal to 4. What R code achieves this? Select all that apply.
x <- c(17, 14, 4, 5, 13, 12, 10) 
x[x>10] <- 4

#based on dataset
#In the dataset provided for this Quiz, what are the column names of the dataset?
table <- read.csv("hw1_data.csv")
Ozone, Solar.R, Wind, Temp, Month, Day

# Extract the first 2 rows of the data frame and print them to the console. What does the output look like?
table[1:2,]

#How many observations (i.e. rows) are in this data frame?
nrows(table)

#Extract the last 2 rows of the data frame and print them to the console. What does the output look like?
tail(table, n=2)

#What is the value of Ozone in the 47th row?
table[47,]

#How many missing values are in the Ozone column of this data frame?
sum(is.na(table[,'Ozone']))

#What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
mean(table[,'Ozone'], na.rm=TRUE)

#Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
sub <- subset(table, Ozone > 31 & Temp > 90)
mean(sub[,'Solar.R'])

#What is the mean of "Temp" when "Month" is equal to 6?
june <- subset(table, Month==6)
mean(june[, 'Temp'])

#What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
may <- subset(table, Month==5)
sort(may[,'Ozone'])

