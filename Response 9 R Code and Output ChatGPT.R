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

# Calculate time difference between consecutive points
data <- data %>%
  mutate(time_diff = lead(timestamp_sec) - timestamp_sec) %>%
  filter(!is.na(time_diff))

# Initialize lists to store segment data
segment_turning_rates <- list()
segment_turning_radius <- list()

# Segment the turn into smaller parts (e.g., 10 segments)
num_segments <- 10
segment_size <- nrow(data) / num_segments

# Calculate turning rate and turning radius for each segment
for (i in 1:num_segments) {
  start_index <- (i - 1) * segment_size + 1
  end_index <- min(i * segment_size, nrow(data))
  segment_data <- data[start_index:end_index, ]
  
  # Calculate turning rate (degrees per second)
  segment_data$turning_rate <- segment_data$angle / segment_data$time_diff
  
  # Calculate turning radius (meters)
  segment_data$turning_radius <- sqrt(segment_data$delta_x^2 + segment_data$delta_y^2)
  
  # Store segment results
  segment_turning_rates[[i]] <- mean(segment_data$turning_rate, na.rm = TRUE)
  segment_turning_radius[[i]] <- mean(segment_data$turning_radius, na.rm = TRUE)
}

# Calculate overall turning rate and turning radius (average of segment values)
overall_turning_rate <- mean(unlist(segment_turning_rates))
overall_turning_radius <- mean(unlist(segment_turning_radius))

# Output the results
cat("Overall Turning Rate (degrees per second):", overall_turning_rate, "\n")
cat("Overall Turning Radius (meters):", overall_turning_radius, "\n")
