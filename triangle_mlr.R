knitr::opts_chunk$set(
  warning = FALSE,       # don't show warnings
  message = FALSE,       # don't show messages (less serious warnings)
  cache = TRUE,          # set to TRUE to save results from last compilation
  fig.align = "center"   # center figures
)

library(tidyverse)       # load libraries you always use here
library(knitr)           # require for purl function to create code appendix
#library(ggplot2)         # for plotting
#library(GGally)          # needed for scatter plot matrix
#library(mvtnorm)        # required for bivariate normal distribution

set.seed(1104)           # make random results reproducible
this_file <- "triangle_mlr.Rmd"  # used to automatically generate code appendix
knitr::include_graphics('./motivation.jpg')
#Specify true angles (tb1,tb2,tb3); tb1 + tb2 should equal tb3
tb1 = 45
tb2 = 45
tb3 = 90

b1 = c(); b1h2 = c();
b2 = c(); b2h2 = c();
b3 = c(); b3h1 = c(); b3h2 = c();
for (i in seq(1,100)){
  b1 = append(b1, tb1 + rnorm(1))
  b2 = append(b2, tb2 + rnorm(1))
  b3 = append(b3, tb3 + rnorm(1))
  
  #Predicting b3 using just b1+b2
  b3h1 = b1+b2
  
  #Predicting b1, b2, b3 using linear combination of b1, b2, b3
  b1h2 = ((2/3)*b1) - ((1/3)*b2) + ((1/3)*b3)
  b2h2 = -((1/3)*b1) + ((2/3)*b2) + ((1/3)*b3)
  b3h2 = ((1/3)*b1) + ((1/3)*b2) + ((2/3)*b3)

}

m = matrix(data = c(1,2), nrow = 1, ncol = 2)
layout(m)
hist(b1); hist(b1h2)
hist(b2); hist(b2h2)

m = matrix(data = c(1,2,3), nrow = 1, ncol = 3)
layout(m)
hist(b3); hist(b3h1); hist(b3h2)

#Create one dataframe for summary stats
#Compare mean, standard deviation to expected mean: 60 for b1, b2 and 120 for b3
df = cbind.data.frame(b1,b2,b3,b3h1,b1h2,b2h2,b3h2) %>%
  summarise(b1_mean = mean(b1), b2_mean = mean(b2), b3_mean = mean(b3), b3h1_mean = mean(b3h1),
            b1h2_mean = mean(b1h2), b2h2_mean = mean(b2h2), b3h2_mean = mean(b3h2))

#Create confidence intervals for each angle

#trilm = lm(b3 ~ b1 + b2)
#summary(trilm)
## code = readLines(purl(this_file, documentation = 0))
