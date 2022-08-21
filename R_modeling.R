library(tidyverse)
library(carat)


## Bianary classification
df <- read_csv("churn.csv")
df%>%(head)
str(df)

## convert churn to factor
df$churn <-factor(df$churn)
table(df$churn)
glimpse(df)
class(churn$totaldaycalls)  

## split data
set.seed(42)
n <- nrow(df)
id <- sample (1:n, size = n*0.8)
train_data <- df[id, ]
test_data <- df[-id, ]
nrow(train_data) ; nrow(test_data)

## train model
logit_model <- glm(churn ~ totaldaycalls, data = train_data, family="binomial")
p_train <- predict(logit_model, type = "response") 
## probability
train_data$pred <- if_else(p_train >= 0.5, "Yes", "No")
mean(train_data$churn == train_data$pred)

## test model
logit_model <- glm(churn ~ totaldaycalls, data = train_data, family="binomial")
p_test <- predict(logit_model, newdata = test_data, type = "response") ## probability
test_data$pred <- if_else(p_test >= 0.5, "Yes", "No")
mean(test_data$churn == test_data$pred)
