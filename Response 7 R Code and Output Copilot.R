# Load required packages
library(tidyverse)

# Read the data file
data <- read.csv("C:\\Users\\ariel\\OneDrive\\BAYLOR\\BIO 5100 AI Coding\\AI coding sea lion data.csv")

# Calculate turning rate (degrees per second)
delta_x <- diff(data$x_space_m)
delta_y <- diff(data$y_space_m)
delta_time <- diff(data$timestamp_sec)
angles <- atan2(delta_y, delta_x) * 180 / pi
turning_rate <- angles / delta_time

# Calculate turning radius (in meters)
radius <- sqrt((data$x_space_m - mean(data$x_space_m))^2 + (data$y_space_m - mean(data$y_space_m))^2)

# Print the results
cat("Turning Rate (degrees per second):", mean(turning_rate), "\n")
cat("Turning Radius (meters):", mean(radius), "\n")
