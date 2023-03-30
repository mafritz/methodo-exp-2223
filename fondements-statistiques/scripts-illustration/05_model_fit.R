# Load required libraries
library(ggplot2)
library(tidyr)

# Set seed for reproducibility
set.seed(42)

# ---- Good Fit Model ----

# Generate data
x_goodfit <- seq(0, 10, 0.5)
y_goodfit <- 2 * x_goodfit + 3 + rnorm(length(x_goodfit), sd = 1)
data_goodfit <- tibble(x_goodfit, y_goodfit) |>
  mutate(
    y_goodfit = rescale(y_goodfit, to = c(0, 100))
  )

# Fit linear regression model
model_goodfit <- lm(y_goodfit ~ x_goodfit, data = data_goodfit)

# Create plot
plot_goodfit <- ggplot(data_goodfit, aes(x = x_goodfit, y = y_goodfit)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, linetype = "solid", color = "blue") +
  ggtitle("Good Fit Model")

# ---- Overfitted Model ----

# Generate data
x_under_over_fit <- seq(0, 10, 0.5)
y_under_over_fit <- 2 * x_under_over_fit^3 + 3 + rnorm(length(x_under_over_fit), sd = 1)
data_under_over_fit <- tibble(x_under_over_fit, y_under_over_fit) |>
  mutate(
    y_under_over_fit = rescale(y_under_over_fit, to = c(0, 100))
  )


# Fit a higher-degree polynomial model (e.g., degree 15)
model_under_over_fit <- lm(y_under_over_fit ~ poly(x_under_over_fit, 15), data = data_under_over_fit)

# Predict using the overfitted model
data_under_over_fit$y_pred <- predict(model_under_over_fit, data_under_over_fit)

# Prepare data for plotting
data_long_under_over_fit <- gather(data_under_over_fit, key = "variable", value = "value", -x_under_over_fit)

# Create plot
plot_under_over_fit <- ggplot(data_long_under_over_fit, aes(x = x_under_over_fit, y = value)) +
  geom_point(size = 3) +
  geom_smooth(method = "loess", color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Overfitted Model", color = "Variable", shape = "Variable", linetype = "Variable")

# Display plots
plot_goodfit
plot_under_over_fit
