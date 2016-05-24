ml <- lm(mpg ~ disp, data = mtcars)

RSS <- function (b) {
  b0 <- b[1]
  b1 <- b[2]
  sum((mtcars$mpg - b0 - b1 * mtcars$disp)^2)
}

optim(c(25, 0.01), RSS)

ml
