library(tidyverse)
library(here)
library(tableone)
library(gt)

# Load the data
heart_data <- read_csv(here("data", "heart_data.csv"))

# Create the outcome variable
heart_data <- heart_data %>%
  mutate(any_heart_disease = ifelse(num > 0, 1, 0))

# Define variables for Table 1
vars <- c("age", "sex", "cp", "trestbps", "chol", "fbs", "restecg", "thalach", "exang", "oldpeak", "slope")

# Create the table one object
table_one <- CreateTableOne(vars = vars, strata = "any_heart_disease", data = heart_data, test = FALSE)

# Convert the print output of the table to a dataframe
table_one_matrix <- print(table_one, printToggle = FALSE)
table_one_df <- as.data.frame(table_one_matrix)

# Add rownames as a column
table_one_df <- table_one_df %>%
  rownames_to_column(var = "Characteristic")

# Create a gt table
table_one_gt <- gt(table_one_df) %>% 
    tab_header(title = "Table 1: Baseline Characteristics")

# Save the gt table as an HTML file
gtsave(table_one_gt, filename = here("results", "table_one.html"))

print("Table 1 saved to results/table_one.html")
