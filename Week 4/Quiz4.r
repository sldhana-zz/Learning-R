#What is produced at the end of this snippet of R code?
set.seed(1)
rpois(5, 2)
#A vector with the numbers 1, 1, 2, 4, 1

#What R function can be used to generate standard Normal random variables?
#rnorm

#When simulating data, why is using the set.seed() function important? Select all that apply.
#It ensures that the sequence of random numbers starts in a specific place and is therefore reproducible.

#Which function can be used to evaluate the inverse cumulative distribution function for the Poisson distribution?
#qpois

#What does the following code do
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
#Generate data from a Normal linear model

#What R function can be used to generate Binomial random variables?
#rbinom

#What aspect of the R runtime does the profiler keep track of when an R
#expression is evaluated? 
#the function call stack

#Consider the following R code
library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
#(Assume that y, x1, and x2 are present in the workspace.) Without running the
#code, what percentage of the run time is spent in the 'lm' function, based on
#the 'by.total' method of normalization shown in 'summaryRprof()'?

#When using `by.total' normalization, the top-level function (in this case, `lm()') always takes 100% of the time.
#100%

#When using 'system.time()', what is the user time?
#It is the time spent by the CPU evaluating an expression

#If a computer has more than one available processor and R is able to take
#advantage of that, then which of the following is true when using
#'system.time()'?
#elapsed time may be smaller than user time

