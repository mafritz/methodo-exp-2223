library(MASS)
library(sjPlot)
library(papaja)
library(tidyverse)
library(report)
library(broom)
library(emmeans)

theme_set(theme_apa(box = TRUE))

set.seed(2524)
n_points <- 20

# Create a dataset with a clear effect of the predictor x
x <- sample(c("A", "B"), n_points, replace = TRUE)
w <- runif(n_points, min = 10, max = 30)
latent_y <- ifelse(x == "A", rnorm(n_points, mean = 0, sd = 1.5), rnorm(n_points, mean = 1.5, sd = 1.5)) + w / 10
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

# Create a new data frame with the values of x and w for which we want to predict probabilities
new_data_glm <- expand.grid(x = c("A", "B"), w = 19.8)

# Obtain predicted probabilities for each level of the outcome variable under both conditions A and B
predicted_probs_glm <- predict(model_glm, newdata = new_data_glm, type = "probs")

# Calculate expected values for each condition
expected_A <- sum(predicted_probs_glm[1, ] * 1:5)
expected_B <- sum(predicted_probs_glm[2, ] * 1:5)

# Find the difference between the expected values of conditions A and B
difference_glm = expected_A - expected_B

# Compare ols regression
model_glm_vs_lm <- lm(as.numeric(outcome) ~ x + w, data_glm)
