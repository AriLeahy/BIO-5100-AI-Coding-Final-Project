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

# Calculate the total distance traveled and the total change in angle
total_distance <- sum(sqrt(data$dx^2 + data$dy^2), na.rm = TRUE)
total_angle_change <- 180  # The sea lion performed a 180 degree turn

# Calculate the turning radius based on the total distance and angle change
turning_radius <- total_distance / (total_angle_change * pi / 180)

# Calculate the average turning rate
avg_turning_rate <- total_angle_change / max(data$timestamp_sec, na.rm = TRUE)

# Print the results
print(paste("Average turning rate (in degrees per second): ", avg_turning_rate))
print(paste("Turning radius (in meters): ", turning_radius))
