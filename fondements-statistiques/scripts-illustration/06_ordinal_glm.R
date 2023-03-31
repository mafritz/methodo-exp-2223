library(MASS)
library(sjPlot)
library(papaja)
library(tidyverse)
library(report)
library(broom)

theme_set(theme_apa(box = TRUE))

set.seed(123)
n_points <- 200

# Create a dataset with a clear effect of the predictor x
x <- sample(c("A", "B"), n_points, replace = TRUE)
w <- rnorm(n_points, mean = 30, sd = 5)
latent_y <- ifelse(x == "A", rnorm(n_points, mean = 0, sd = 1), rnorm(n_points, mean = 1, sd = 1)) + w / 10
outcome <- cut(latent_y, breaks = quantile(latent_y, probs = seq(0, 1, length.out = 6)), include.lowest = TRUE, labels = 1:5, ordered_result = TRUE)

data_glm <- data.frame(x, w, outcome)

# Fit the ordered logistic regression model
model_glm <- polr(outcome ~ x + w, data = data_glm, Hess = TRUE)
summary(model_glm)

# Plot the predicted probabilities
plot_model(model_glm, type = "pred", terms = c("x"), )

# Get the summary of the model
model_summary <- summary(model_glm)

# Extract the coefficients and the standard errors
coefs <- model_summary$coefficients[, "Value"]
std_errors <- model_summary$coefficients[, "Std. Error"]

# Calculate the z-values (t-values)
z_values <- coefs / std_errors

# Calculate the p-values
p_values <- 2 * (1 - pnorm(abs(z_values)))

# Combine the coefficients, standard errors, z-values, and p-values into a data frame
results <- data.frame(
  Estimate = coefs,
  `Std. Error` = std_errors,
  `z-value` = z_values,
  `p-value` = p_values
)

# Print the results
print(results, digits = 3)

equation_glm <- equatiomatic::extract_eq(model_glm, intercept = "beta")
equation_glm_coeff <- equatiomatic::extract_eq(model_glm, use_coefs = TRUE, intercept = "beta")
