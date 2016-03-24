library(ggplot2)
library(dplyr)
library(binom)
library(zoo)
library(lazyeval)

#' LOESS Plot for Binary Variable
#'
#' \code{prob_var_plot} creates a ggplot2 plot with a Bernoulli LOESS for
#' binary versus continuous variable. This should be useful as a way to
#' determine the relationship between a continuous variable and a binary
#' variable.
#'
#' It returns a ggplot2 plot, so one could easily add other elements to the
#' plot, such as titles, axes labels, and other themes.
#'
#' @param data The dataframe containing the binary and continuous variable
#' @param x_var The name of the continuous variable (as a string)
#' @param y_var The name of the binary response variable (as a string)
#' @param window_width Width of the window to use for approximating p.
#' @param method The method to be used to find confidence intervals for
#'  binomial variables. See documentation for binom.confint for options.
#'
#' @return A ggplot2 plot.
#'
#' @examples
#' x <- rnorm(100, 0, 2000)
#' y <- rbinom(100, 1, invlogit(x/1000))
#' test_data <- data.frame(x, y)
#' p <- prob_var_plot(test_data, "x", "y")
#' p
#' p + labs(title="Empirical probability versus Gaussian variable")
#'
#' n <- 1e4
#' x <- rnorm(n, 0, 2000)
#' y <- rbinom(n, 1, invlogit(x / 1000))
#' test_data <- data.frame(x, y)
#' prob_var_plot(test_data, "x", "y")

prob_var_plot <- function(data, x_var, y_var, method="bayes") {

    in_window <- function(x, width, x_vec) {
      subsetSorted(x_vec, x - width/2, x + width/2)
    }
    estimate_p <- function(x) { sum(x) / length(x)}
    count_true <- function(x_in_window, y_vec) {
      sum(y_vec[x_in_window])
      }
    count_window <- function(x_in_window) {
      length(x_in_window)
      }

  # Load and filter data =======================================================
  n <- 1000
  orig_data <- data %>% select_(x_var, y_var)
  orig_data <- filter(orig_data, complete.cases(orig_data))
  orig_data[[y_var]] <- as.numeric(orig_data[[y_var]])
  orig_data <- arrange_(orig_data, interp(~ var, var = as.name(x_var)))
  print(orig_data[[x_var]])

  log_likelihood <- function (p_loo, y, N) {
    (-1/N) * sum(log(p_loo^y * (1 - p_loo)^(1-y)))
  }
  log_likelihood2 <- function(p_loo, y, N) {
    (-1/N) * sum(log(ifelse(y == 1, p_loo, 1 - p_loo)))
  }

  CV_likelihood <- function(window_width) {
    # Get leave-one-out estimates
    LOO_estimate <- function(i) {
      estimate_LOO_p(orig_data[[x_var]], orig_data[[y_var]], window_width, i)
    }
    p_loo <- vapply(1:nrow(orig_data), LOO_estimate, 1)
    y <- orig_data[[y_var]]
    N <- nrow(orig_data)
    log_likelihood(p_loo, y, N)
  }


  width_of_interval <- orig_data[[x_var]] %>% range() %>% diff()
  window_width <- optimize(CV_likelihood,
                           interval=c(0, width_of_interval),
                           tol = width_of_interval / 1E4)$minimum

  # Now create plot with chosen width

  plot_data <- data.frame(x_reg = seq(from=min(orig_data[[x_var]]),
                                      to=max(orig_data[[x_var]]),
                                      length.out = n),
                          count = rep(0,n),
                          total = rep(0,n))

  # Compute counts for each window
  for (i in 1:nrow(plot_data)) {
    x_in_window <- in_window(plot_data$x_reg[i], window_width, orig_data[[x_var]])
   plot_data$count[i] <- count_true(x_in_window, orig_data[[y_var]])
    plot_data$total[i] <- count_window(x_in_window)
  }

  # Compute confidence intervals for all the windows
  conf_int <- binom.confint(plot_data$count, plot_data$total, method=method)

  # Create the plot
  ggplot() +
    geom_point(shape=124, aes(x = orig_data[[x_var]],
                              y = orig_data[[y_var]]), data = orig_data) +
    geom_ribbon(data = conf_int, aes(x = plot_data$x_reg, ymin = lower, ymax = upper)) +
    geom_line(data = conf_int, aes(x = plot_data$x_reg, y= mean))

}




# Tests
n <- 1000000
p <- runif(n, 0, 1)
y <- rbinom(n, 1, p)
system.time(log_likelihood(p, y, n))
system.time(log_likelihood2(p, y, n))

