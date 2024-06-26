# Load necessary libraries
install.packages("tidyverse")
library(tidyverse)

# Read the data
data <- read.csv("C:\\Users\\ariel\\OneDrive\\BAYLOR\\BIO 5100 AI Coding\\AI coding sea lion data.csv")

# Calculate the differences in x, y coordinates and time
data <- data %>%
  mutate(dx = lead(x_space_m) - x_space_m,
         dy = lead(y_space_m) - y_space_m,
         dt = lead(timestamp_sec) - timestamp_sec)

# Calculate the velocities and accelerations
data <- data %>%
  mutate(vx = dx / dt,
         vy = dy / dt,
         ax = lead(vx) / dt,
         ay = lead(vy) / dt)

# Calculate the curvature, turning radius and turning rate
data <- data %>%
  mutate(curvature = abs(vx * ay - vy * ax) / (vx^2 + vy^2)^(3/2),
         radius = 1 / curvature,
         turning_rate = sqrt(vx^2 + vy^2) * curvature * 180 / pi)

# Calculate the average turning rate and turning radius
avg_turning_rate <- mean(data$turning_rate, na.rm = TRUE)
avg_turning_radius <- mean(data$radius, na.rm = TRUE)

# Print the results
print(paste("Average turning rate (in degrees per second): ", avg_turning_rate))
print(paste("Average turning radius (in meters): ", avg_turning_radius))
