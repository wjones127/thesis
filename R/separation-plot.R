library(ggplot2)

#' Creates a separation plot for diagnosing logistic regression models.
#'
#' \code{separation_plot} Create a separation plot based on paper.
#'
#' @examples
#' x <- rnorm(100, 0, 2000)
#' y <- rbinom(100, 1, invlogit(x/1000)) == 1
#' test_data <- data.frame(x, y)
#' model <- glm(y ~ x, data = test_data, family = binomial)
#' test_data$yhat <- predict(model, type = "response")
#' p <- separation_plot(test_data, "y", "yhat")
#' p
separation_plot <- function(data, col.actual, col.probs) {
  results <- data %>%
    arrange_(col.probs) %>%
    select_(col.actual, col.probs) %>%
    rename_(Y = col.actual, Yhat = col.probs)

  expected.true = sum(results$Y)

  ggplot(results) +
    geom_rect(aes(xmin = 0, xmax = seq(length.out = length(Yhat)), ymin = 0, ymax = 1),
              fill = "white") +
    geom_linerange(aes(color = Y, ymin = 0, ymax = 1,
                       x = seq(length.out = length(Yhat)))) +
    geom_line(aes(y = Yhat, x = seq(length.out = length(Yhat))), lwd = 0.8)  +
    scale_y_continuous("Y-hat\n", breaks = c(0, 0.25, 0.5, 0.75, 1.0)) +
    scale_x_continuous("", breaks = NULL) +
    theme_linedraw() +
    scale_colour_grey(start=1, end=0) +
    geom_point(aes(y = 0, x = length(Yhat) - expected.true), shape=17)
}
