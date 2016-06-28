#Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code:
library(datasets)
data(iris)

#There will be an object called 'iris' in your workspace. In this dataset, what
#is the mean of 'Sepal.Length' for the species virginica? Please round your
#answer to the nearest whole number.
tapply(iris$Sepal.Length, iris$Species=='virginica', mean)
mean(iris$Sepal.Length[iris$Species=="virginica"], na.rm=TRUE)

virginicaList <- subset(iris, iris$Species=='virginica')$Sepal.Length
lapply(list(virginicaList), mean)
#6.588

#Continuing with the 'iris' dataset from the previous Question, what R code
#returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width',
#'Petal.Length', and 'Petal.Width'?
#run apply on columns 1 - 4, 2 means column
apply(iris[, 1:4], 2, mean)

#Load the 'mtcars' dataset in R with the following code
library(datasets)
data(mtcars)

#How can one calculate the average miles per gallon (mpg) by number of cylinders
#in the car (cyl)? Select all that apply.
tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))

#Continuing with the 'mtcars' dataset from the previous Question, what is the
#absolute difference between the average horsepower of 4-cylinder cars and the
#average horsepower of 8-cylinder cars?
tapply(mtcars$hp, list(mtcars$cyl==4, mtcars$cyl==8), mean)
#126.5779

#If you run
debug(ls)
ls
