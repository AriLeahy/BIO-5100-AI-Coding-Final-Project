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

# Calculate the instantaneous velocity and angular velocity
data <- data %>%
  mutate(velocity = sqrt(dx^2 + dy^2) / dt,
         angular_velocity = 180 / dt)

# Calculate the radius of the turn (v = w*r)
data <- data %>%
  mutate(radius = velocity / (angular_velocity * pi / 180))

# Calculate the average turning rate and turning radius
avg_turning_rate <- mean(data$angular_velocity, na.rm = TRUE)
avg_turning_radius <- mean(data$radius, na.rm = TRUE)

# Print the results
print(paste("Average turning rate (in degrees per second): ", avg_turning_rate))
print(paste("Average turning radius (in meters): ", avg_turning_radius))
