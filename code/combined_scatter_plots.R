# Combined Scatter Plots Analysis
# Load necessary libraries
library(tidyverse)
library(here)

# Load the processed data
heart_data <- read_csv(here("data", "heart_data.csv"))

# Plot 1: Age vs. Cholesterol
plot1 <- ggplot(heart_data, aes(x = age, y = chol)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Age vs. Cholesterol",
    x = "Age",
    y = "Cholesterol (mg/dl)"
  ) +
  theme_minimal()

# Plot 2: Cholesterol vs. Maximum Heart Rate by Heart Disease Status
plot2 <- heart_data %>% 
  mutate(any_heart_disease = factor(any_heart_disease, levels = c(0, 1), labels = c("No", "Yes"))) %>% 
  ggplot(aes(x = thalach, y = chol, color = any_heart_disease)) + 
  geom_point(alpha = 0.7) + 
  labs(title = "Cholesterol vs. Maximum Heart Rate by Heart Disease Status",
       x = "Maximum Heart Rate Achieved (thalach)",
       y = "Cholesterol (mg/dl)",
       color = "Heart Disease") + 
  theme_minimal()

# Plot 3: Age vs. Maximum Heart Rate by Heart Disease Status
plot3 <- heart_data %>% 
  mutate(any_heart_disease = factor(any_heart_disease, levels = c(0, 1), labels = c("No", "Yes"))) %>% 
  ggplot(aes(x = age, y = thalach, color = any_heart_disease)) + 
  geom_point(alpha = 0.7) + 
  labs(title = "Age vs. Maximum Heart Rate by Heart Disease Status",
       x = "Age",
       y = "Maximum Heart Rate Achieved (thalach)",
       color = "Heart Disease") + 
  theme_minimal()

# Plot 4: Resting Blood Pressure vs. Cholesterol by Heart Disease Status (New)
plot4 <- heart_data %>% 
  mutate(any_heart_disease = factor(any_heart_disease, levels = c(0, 1), labels = c("No", "Yes"))) %>% 
  ggplot(aes(x = trestbps, y = chol, color = any_heart_disease)) + 
  geom_point(alpha = 0.7) + 
  labs(title = "Resting Blood Pressure vs. Cholesterol by Heart Disease Status",
       x = "Resting Blood Pressure (mmHg)",
       y = "Cholesterol (mg/dl)",
       color = "Heart Disease") + 
  theme_minimal()

# Save all plots
ggsave(here("results", "age_vs_chol_scatter.png"), plot = plot1)
ggsave(here("results", "cholesterol_vs_exercise.pdf"), plot = plot2, device = "pdf")
ggsave(here("results", "age_vs_max_hr.pdf"), plot = plot3, device = "pdf")
ggsave(here("results", "bp_vs_chol_scatter.png"), plot = plot4)

print("All plots saved to results directory:")
print("- age_vs_chol_scatter.png")
print("- cholesterol_vs_exercise.pdf")
print("- age_vs_max_hr.pdf")
print("- bp_vs_chol_scatter.png (new)")