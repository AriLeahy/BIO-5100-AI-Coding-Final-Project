# Load necessary libraries (if not already installed)
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
library(dplyr)

# Given data
length_m <- 1.96  # Animal body length in meters
timestamps <- c(0.016667, 0.033334, 0.050001, 0.066668, 1.016667, 1.033334, 1.050001, 1.066668, 2.016667, 2.033334, 2.050001, 2.066668, 3.016667, 3.033334, 3.050001)
x_space_m <- c(0.625, 0.623, 0.630, 0.638, 0.643, 0.668, 0.693, 0.725, 0.752, 0.792, 0.842, 0.875, 0.922, 0.967, 1.002)
y_space_m <- c(0.703, 0.655, 0.613, 0.578, 0.533, 0.486, 0.453, 0.423, 0.396, 0.366, 0.344, 0.326, 0.316, 0.316, 0.321)

# Calculate total turning angle (in radians)
total_theta_rad <- sum(diff(atan2(y_space_m, x_space_m)))

# Calculate turning rate (angular velocity) in degrees per second
total_time_sec <- max(timestamps) - min(timestamps)
turning_rate_deg_per_sec <- total_theta_rad * (180 / pi) / total_time_sec

# Calculate turning radius
turning_radius_m <- length_m / (2 * sin(total_theta_rad / 2))

# Convert turning rate to radians
turning_rate_rad_per_sec <- total_theta_rad

# Calculate turning velocity (linear velocity)
turning_velocity_m_per_sec <- turning_radius_m * turning_rate_rad_per_sec

# Calculate centripetal acceleration
centripetal_acceleration_m_per_sec2 <- turning_velocity_m_per_sec^2 / turning_radius_m

# Calculate g-force (in multiples of gravitational force)
g_force <- centripetal_acceleration_m_per_sec2 / 9.8

# Print results
cat("Total Turning Rate (degrees per second):", turning_rate_deg_per_sec, "\n")
cat("Total Turning Radius (meters):", turning_radius_m, "\n")
cat("Total Turning Velocity (meters per second):", turning_velocity_m_per_sec, "\n")
cat("Total Centripetal Acceleration (meters per second squared):", centripetal_acceleration_m_per_sec2, "\n")
cat("Total G-Force (multiples of gravitational force):", g_force, "\n")
