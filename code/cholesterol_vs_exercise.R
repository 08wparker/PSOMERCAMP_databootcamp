# Load necessary libraries
library(tidyverse)
library(here)

# Load the processed data
heart_data <- read_csv(here("data", "heart_data.csv"))

# Create the plot
plot <- heart_data %>% 
  mutate(any_heart_disease = factor(any_heart_disease, levels = c(0, 1), labels = c("No", "Yes"))) %>% 
  ggplot(aes(x = thalach, y = chol, color = any_heart_disease)) + 
  geom_point(alpha = 0.7) + 
  labs(title = "Cholesterol vs. Maximum Heart Rate by Heart Disease Status",
       x = "Maximum Heart Rate Achieved (thalach)",
       y = "Cholesterol (mg/dl)",
       color = "Heart Disease") + 
  theme_minimal()

# Save the plot as a PDF
ggsave(here("results", "cholesterol_vs_exercise.pdf"), plot = plot, device = "pdf")
