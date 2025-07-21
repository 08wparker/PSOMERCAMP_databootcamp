# Load necessary libraries
library(tidyverse)
library(here)

# Load the processed data
heart_data <- read_csv(here("data", "heart_data.csv"))

# Create the plot
plot <- heart_data %>% 
  mutate(any_heart_disease = factor(any_heart_disease, levels = c(0, 1), labels = c("No", "Yes"))) %>% 
  ggplot(aes(x = age, y = thalach, color = any_heart_disease)) + 
  geom_point(alpha = 0.7) + 
  labs(title = "Age vs. Maximum Heart Rate by Heart Disease Status",
       x = "Age",
       y = "Maximum Heart Rate Achieved (thalach)",
       color = "Heart Disease") + 
  theme_minimal()

# Save the plot as a PDF
ggsave(here("results", "age_vs_max_hr.pdf"), plot = plot, device = "pdf")
