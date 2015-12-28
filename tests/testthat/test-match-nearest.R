library(dplyr)
library(FNN)
library(wjonesthesis)

t1 <- match.nearest(c(1, 0), c(1, 0), c(1, -0.2, -1), c(1, -0.1, -2))

test_that("match.nearest gives correct output", {
  expect_equal(t1$nn.index[1], 1)
  expect_equal(t1$nn.dist[1], 0)
})


query <- data.frame(price = c(1.23, 5.34, 2.00),
                    long = c(2, -3, 1.5),
                    lat = c(2,3, 1.7))

data <- data.frame(height = c(3.4, 5.9),
                   long = c(2, -5),
                   lat = c(2, 4))

result <- left_join.by.nearest(query, data, dist = TRUE)

test_that("left_join.by.nearest keeps original columns",{
  expect_equal(length(result$price), 3)
  expect_equal(result$price[1], 1.23)
})

test_that("left_Join.by.nearest adds additional columns", {
  expect_equal(length(result$height), 3)
  expect_equal(result$height[1], 3.4)
})
