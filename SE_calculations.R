# clear environment
rm(list = ls())

# load data
source('flex_outcomes.R')

# load necessary libraries
library(exact2x2)

# difference in proportion
n <- nrow(conclusions)
p1 <- 56/n
p2 <- 51/n
prop_diff <- p1-p2

# Wald confidence interval
prop_lower <- prop_diff - qnorm(0.975)*sqrt((p1*(1-p1)/n) + (p2*(1-p2)/n))
prop_upper <- prop_diff + qnorm(0.975)*sqrt((p1*(1-p1)/n) + (p2*(1-p2)/n))

# rounded values 
round(prop_diff*100, 1)
round(prop_lower*100, 1)
round(prop_upper*100, 1)

# contingency table
cont.table <- matrix(
  c(sum(conclusions$agreed_HRandDRMST & conclusions$margin_HR), 
    sum(!conclusions$agreed_HRandDRMST & conclusions$margin_HR), 
    sum(!conclusions$agreed_HRandDRMST & !conclusions$margin_HR), 
    sum(conclusions$agreed_HRandDRMST & !conclusions$margin_HR)),
  nrow = 2, byrow = T)

# mcNemar test 
# mcnemar.test(cont.table, correct = T)
mcnemar.exact(cont.table)
