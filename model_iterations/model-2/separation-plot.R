library(dplyr)
library(ggplot2)

#' Creates a separation plot for diagnosing logistic regression models.
#'
#' \code{separation_plot} Create a separation plot based on paper.
#'
#' @examples
#' x <- rnorm(1000, 0, 2000)
#' y <- rbinom(1000, 1, invlogit(x/1000)) == 1
#' test_data <- data.frame(x, y)
#' model <- glm(y ~ x, data = test_data, family = binomial)
#' test_data$yhat <- predict(model, type = "response")
#' p <- separation_plot(test_data, "y", "yhat")
#' p
separation_plot <- function(data, col.actual, col.probs, min.ink = TRUE, sample = nrow(data) > 1000) {

  results <- data %>%
    arrange_(col.probs) %>%
    select_(col.actual, col.probs) %>%
    rename_(Y = col.actual, Yhat = col.probs)

  if (sample) results <- sample_n(results, 1000) %>% arrange_(col.probs)

  expected.true = sum(results$Y)

  base_plot <- ggplot(results) +
#    geom_rect(aes(xmin = 0, xmax = seq(length.out = length(Yhat)), ymin = 0, ymax = 1),
 #             fill = "white") +
    #geom_linerange(aes(color = Y, ymin = 0, ymax = 1,
    #                   x = seq(length.out = length(Yhat)))) +
    geom_rect(aes(fill = Y, xmin = seq(length.out = length(Yhat)), xmax = seq(length.out = length(Yhat)) + 1),
              ymin = 0, ymax = 1) +
    geom_line(aes(y = Yhat, x = seq(length.out = length(Yhat))), lwd = 0.8)  +
    scale_y_continuous("Y-hat\n", breaks = c(0, 0.25, 0.5, 0.75, 1.0)) +
    scale_x_continuous("", breaks = NULL) +
    scale_fill_grey(start=.95, end=.2) +
    geom_point(aes(y = 0, x = length(Yhat) - expected.true), shape=17)

  if (min.ink) {
  base_plot <- base_plot + theme(legend.position = "none",
                                 axis.line = element_blank(),
                                 axis.text.x = element_blank(),
                                 axis.text.y = element_blank(),
                                 axis.title.y = element_blank(),
                                 axis.title.x = element_blank(),
                                 axis.ticks = element_blank(),
                                 panel.border = element_blank(),
                                 panel.grid.major = element_blank(),
                                 panel.grid.minor = element_blank(),
                                 plot.background = element_blank(),
                                 panel.background = element_blank(),
                                 plot.margin = unit(c(0,0,0,0), "cm"),
                                 panel.margin = unit(c(0,0,0,0), "cm"))
  }

  base_plot
}
