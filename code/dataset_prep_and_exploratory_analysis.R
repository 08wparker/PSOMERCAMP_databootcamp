# Load the necessary libraries
# You may need to install these packages first using install.packages("package_name")
# Load the tidyverse for data manipulation and visualization
# Load the here package to help set the working directory

# for data manipulation and visualization
library(tidyverse)

# to help set the working directory and make this script reproducible across different machines
library(here)

# for Table one
library(tableone)

# you are unlikely to need col_names = FALSE
heart_data <- read_csv(here::here("data", "processed.cleveland.data"), col_names = FALSE)

# here I am labeling the columns- you might need to do this!
column_names <- c(
  "age", "sex", "cp", "trestbps", "chol", "fbs", "restecg",
  "thalach", "exang", "oldpeak", "slope", "ca", "thal", "num"
)

heart_data <- heart_data %>% 
  setNames(column_names)

# Inclusion criteria: age 40-70
heart_data <- heart_data %>% 
  filter(age >= 40 & age <= 70)

# construct binary primary outcome of any_heart_disease from num > 0
heart_data <- heart_data %>% 
  mutate(any_heart_disease = ifelse(num > 0, 1, 0))

write_csv(heart_data, here::here("data", "heart_data.csv"))

# Create a table one for the final cohort
table_one <- CreateTableOne(data = heart_data)

table_one

mean_age <- mean(heart_data$age, na.rm = TRUE)
median_age <- median(heart_data$age, na.rm = TRUE)
mode_age <- as.numeric(names(sort(table(heart_data$age), decreasing = TRUE)[1]))

mean_age

median_age

mode_age

mean_age_heart_disease <- heart_data %>% 
  filter(any_heart_disease == 1) %>% 
  summarise(mean_age = mean(age, na.rm = TRUE))

mean_age_heart_disease

mean_age_no_heart_disease <- heart_data %>% 
  filter(any_heart_disease == 0) %>% 
  summarise(mean_age = mean(age, na.rm = TRUE))

mean_age_no_heart_disease

t_test_result <- t.test(age ~ any_heart_disease, data = heart_data)

t_test_result

# Create a logistic regression model to assess the association of age with heart disease
logistic_model <- glm(any_heart_disease ~ age, data = heart_data, family = binomial)

summary(logistic_model)

exp(0.05199)


### adujsted logistic regression model controlling for cholesterol
logistic_model_adjusted <- glm(any_heart_disease ~ age + chol, 
                               data = heart_data, family = binomial)

summary(logistic_model_adjusted)
