library(MASS)
library(sjPlot)
library(papaja)
library(tidyverse)
library(report)
library(broom)
library(emmeans)

theme_set(theme_apa(box = TRUE))

set.seed(123)
n_points <- 200

# Create a dataset with a clear effect of the predictor x
x <- sample(c("A", "B"), n_points, replace = TRUE)
w <- runif(n_points, min = 10, max = 30)
latent_y <- ifelse(x == "A", rnorm(n_points, mean = 0, sd = 1), rnorm(n_points, mean = 1, sd = 1)) + w / 10
outcome <- cut(latent_y, breaks = quantile(latent_y, probs = seq(0, 1, length.out = 6)), include.lowest = TRUE, labels = 1:5, ordered_result = TRUE)

data_glm <- data.frame(x, w, outcome)

# Fit the ordered logistic regression model
model_glm <- polr(outcome ~ x + w, data = data_glm, Hess = TRUE)

# Plot the predicted probabilities
graph_glm <- plot_model(model_glm, type = "pred", terms = c("x", "w"))

# Get the summary of the model
model_glm_summary <- summary(model_glm)

# Extract the coefficients and the standard errors
coefs <- model_glm_summary$coefficients[, "Value"]
std_errors <- model_glm_summary$coefficients[, "Std. Error"]

# Calculate the z-values (t-values)
z_values <- coefs / std_errors

# Calculate the p-values
p_values <- 2 * (1 - pnorm(abs(z_values)))

format_pvalue <- function(p) {
  if (p < 0.001) {
    return("<0.001")
  } else {
    return(sprintf("%.3f", p))
  }
}

# Combine the coefficients, standard errors, z-values, and p-values into a data frame
results_glm <- data.frame(
  Estimate = coefs,
  `Std. Error` = std_errors,
  `z-value` = z_values,
  `p-value` = p_values
)

results_glm$p.value = sapply(results_glm$p.value, format_pvalue)

# Print the results_glm
print(results_glm, digits = 3)

equation_glm <- equatiomatic::extract_eq(model_glm, intercept = "beta")
equation_glm_coeff <- equatiomatic::extract_eq(model_glm, use_coefs = TRUE, intercept = "beta")

model_glm_contrast <- emmeans(model_glm, ~x | w) |> pairs()

