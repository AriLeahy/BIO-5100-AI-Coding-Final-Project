# Install and load necessary packages
install.packages("pracma")
library(pracma)

# Given data
data <- data.frame(
  timestamp_sec = c(0.016667, 0.033334, 0.050001, 0.066668, 1.016667, 1.033334, 1.050001, 1.066668, 2.016667, 2.033334, 2.050001, 2.066668, 3.016667, 3.033334, 3.050001),
  x_space_m = c(0.625, 0.623, 0.63, 0.638, 0.643, 0.668, 0.693, 0.725, 0.752, 0.792, 0.842, 0.875, 0.922, 0.967, 1.002),
  y_space_m = c(0.703, 0.655, 0.613, 0.578, 0.533, 0.486, 0.453, 0.423, 0.396, 0.366, 0.344, 0.326, 0.316, 0.316, 0.321),
  length_m = c(1.96, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)
)

# Function to calculate turning rate in degrees per second
calculate_turning_rate <- function(x, y, timestamp) {
  dx_dt <- gradient(x, timestamp) # Derivative of x wrt time
  dy_dt <- gradient(y, timestamp) # Derivative of y wrt time
  turning_rate <- atan2(dy_dt, dx_dt) * (180 / pi) # Convert to degrees
  return(turning_rate)
}

# Function to calculate turning radius in meters
calculate_turning_radius <- function(x, y) {
  dx_dt <- gradient(x)
  dy_dt <- gradient(y)
  d2x_dt2 <- gradient(dx_dt)
  d2y_dt2 <- gradient(dy_dt)
  turning_radius <- ((dx_dt^2 + dy_dt^2)^(3/2)) / abs(dx_dt * d2y_dt2 - dy_dt * d2x_dt2)
  return(turning_radius)
}

# Calculate turning rate
data$turning_rate_deg_per_sec <- calculate_turning_rate(data$x_space_m, data$y_space_m, data$timestamp_sec)

# Calculate turning radius
data$turning_radius_m <- calculate_turning_radius(data$x_space_m, data$y_space_m)

# Convert turning rate to radians
data$turning_rate_rad_per_sec <- data$turning_rate_deg_per_sec * (pi / 180)

# Calculate turning velocity in meters per second
data$turning_velocity_m_per_sec <- data$turning_radius_m * data$turning_rate_rad_per_sec

# Calculate centripetal acceleration in meters per second squared
data$centripetal_acceleration_m_per_sec2 <- data$turning_velocity_m_per_sec^2 / data$turning_radius_m

# Calculate g-force of the turn (in multiples of gravitational force)
g <- 9.81 # gravitational constant in m/s^2
data$g_force <- data$centripetal_acceleration_m_per_sec2 / g

# Output the calculated values
print(data[, c("timestamp_sec", "turning_rate_deg_per_sec", "turning_radius_m", "turning_velocity_m_per_sec", "centripetal_acceleration_m_per_sec2", "g_force")])
