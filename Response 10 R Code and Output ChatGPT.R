# Install and load necessary packages
install.packages("tidyverse")
install.packages("minpack.lm")
library(tidyverse)
library(minpack.lm)

# Read the data from the CSV file
data <- read.csv("C:\\Users\\ariel\\OneDrive\\BAYLOR\\BIO 5100 AI Coding\\AI coding sea lion data.csv")

# Calculate change in x and y coordinates
data <- data %>%
  mutate(delta_x = lead(x_space_m) - x_space_m,
         delta_y = lead(y_space_m) - y_space_m)

# Fit a quadratic curve to the data points
fit <- nlsLM(y_space_m ~ a * x_space_m^2 + b * x_space_m + c, data = data, start = list(a = 1, b = 1, c = 1))

# Calculate curvature from the fitted curve
curvature <- coef(fit)[1] / (1 + coef(fit)[2]^2)^1.5

# Calculate turning radius (meters) from curvature
turning_radius <- 1 / curvature

# Output the results
cat("Turning Radius (meters):", turning_radius, "\n")
