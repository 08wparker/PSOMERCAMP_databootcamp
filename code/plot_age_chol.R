library(tidyverse)
library(here)

# Load the data
heart_data <- read_csv(here("data", "heart_data.csv"))

# Create the plot
plot <- ggplot(heart_data, aes(x = age, y = chol)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Age vs. Cholesterol",
    x = "Age",
    y = "Cholesterol (mg/dl)"
  ) +
  theme_minimal()

# Save the plot
ggsave(here("results", "age_vs_chol_scatter.png"), plot = plot)

print("Plot saved to results/age_vs_chol_scatter.png")
