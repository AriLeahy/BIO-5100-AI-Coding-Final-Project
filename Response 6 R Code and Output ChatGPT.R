# Install and load necessary packages
install.packages("tidyverse")
library(tidyverse)

# Read the data from the CSV file
data <- read.csv("C:\\Users\\ariel\\OneDrive\\BAYLOR\\BIO 5100 AI Coding\\AI coding sea lion data.csv")

# Calculate change in x and y coordinates
data <- data %>%
  mutate(delta_x = lead(x_space_m) - x_space_m,
         delta_y = lead(y_space_m) - y_space_m)

# Calculate angle of turn
data <- data %>%
  mutate(angle = atan2(delta_y, delta_x) * 180 / pi) %>%
  filter(!is.na(angle))

# Calculate turning rate (degrees per second)
data <- data %>%
  mutate(time_diff = lead(timestamp_sec) - timestamp_sec) %>%
  filter(!is.na(time_diff)) %>%
  mutate(turning_rate = angle / time_diff)

# Calculate turning radius (meters)
data <- data %>%
  mutate(turning_radius = sqrt(delta_x^2 + delta_y^2))

# Calculate overall turning rate and turning radius
overall_turning_rate <- mean(data$turning_rate, na.rm = TRUE)
overall_turning_radius <- mean(data$turning_radius, na.rm = TRUE)

# Output the results
cat("Overall Turning Rate (degrees per second):", overall_turning_rate, "\n")
cat("Overall Turning Radius (meters):", overall_turning_radius, "\n")
