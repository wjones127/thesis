library(ggplot2)
library(extrafont)

df <- data.frame(est = c(0.1, 0.2, -0.5),
                 lwr = c(0.02, -0.1, -0.7),
                 upr = c(1.83, 0.34, 0.1),
                 name = c("beta1", "beta2", "beta3"))




# $\gamma^\text{freq}$ & 0.08 & -0.19 & 0.35\\
# $\gamma^\text{weekend}$ & -0.13 & -0.50 & 0.35\\
# $\gamma^\text{morning}$ & 0.06 & -0.22 & 0.34\\
# $\gamma^\text{afternoon}$ & 0.13 & -0.20 & 0.44\\
# $\gamma^\text{evening}$ & -0.02 & -0.31 & 0.27\\
# $\gamma^\text{med.len}$ & 0.01 & -0.25 & 0.29\\
# $\gamma^\text{med.len.w}$ & 0.08 & -0.19 & 0.36\\
# $\gamma^\text{var.len}$ & 0.07 & -0.15 & 0.31\\
# $\gamma^\text{var.len.w}$ & -0.15 & -0.47 & 0.17\\
# $\gamma_0$ & -2.99 & -3.29 & -2.69\\
# $\sigma_\alpha$ & 1.47 & 1.27 & 1.69\\

var_names <- c("freq",
           "weekend",
           "morning",
           "afternoon",
           "evening",
           "med.len",
           "med.len.w",
           "var.len",
           "var.len.w",
           "intercept",
           "sigma")

est <- c(0.08, -0.13, 0.06, 0.13, -0.02, 0.01, 0.08, 0.07, -0.15, -2.99, 1.47)
lwr <- c(-0.19, -0.5, -0.22, -0.2, -0.31, -0.25, -0.19, -0.15, -0.47, -3.29, 1.27)
upr <- c(0.35, 0.35, 0.34, 0.44, 0.27, 0.29, 0.36, 0.31, 0.17, -2.69, 1.69)

stan_results <- data.frame(var_names, est, lwr, upr)

ggplot(stan_results, aes(x = est, y = var_names)) +
  geom_point(size = 2) +
  geom_errorbarh(aes(xmin = lwr, xmax = upr), height = 0) +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_bw(base_family = "CMU Serif") +
  labs(title = "Coefficients for Rider-level predictors",
       x = "Estimate with 95% CI",
       y = "Rider-level predictor")
ggsave("plots/stan-model-results.pdf", width = 4.5, height = 4)
