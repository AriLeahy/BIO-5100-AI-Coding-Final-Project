# Load necessary libraries (if not already installed)
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
library(tidyverse)

# Read the CSV file
data_file <- "C:\\Users\\ariel\\OneDrive\\BAYLOR\\BIO 5100 AI Coding\\AI coding sea lion data.csv"
sea_lion_data <- read.csv(data_file)

# Calculate turning parameters
delta_theta_rad <- diff(atan2(sea_lion_data$y_space_m, sea_lion_data$x_space_m))
delta_time_sec <- diff(sea_lion_data$timestamp_sec)
total_theta_rad <- sum(delta_theta_rad)

# Turning rate (angular velocity) in degrees per second
turning_rate_deg_per_sec <- total_theta_rad * (180 / pi) / total_time_sec

# Turning radius
turning_radius_m <- sea_lion_data$length_m / (2 * sin(total_theta_rad / 2))

# Convert turning rate to radians
turning_rate_rad_per_sec <- total_theta_rad

# Turning velocity (linear velocity)
turning_velocity_m_per_sec <- turning_radius_m * turning_rate_rad_per_sec

# Calculate centripetal acceleration
centripetal_acceleration_m_per_sec2 <- turning_velocity_m_per_sec^2 / turning_radius_m

# Calculate g-force (in multiples of gravitational force)
g_force <- centripetal_acceleration_m_per_sec2 / 9.8

# Create a summary table without NA values
summary_table <- data.frame(
  Parameter = c("Turning Rate", "Turning Radius", "Turning Velocity",
                "Centripetal Acceleration", "G-Force"),
  Value = c(turning_rate_deg_per_sec, turning_radius_m,
            turning_velocity_m_per_sec, centripetal_acceleration_m_per_sec2,
            g_force)
) %>%
  na.omit()  # Remove rows with NA values

# Print the updated summary table
print(summary_table)
