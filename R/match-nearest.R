library(FNN)
#' Get nearest data point for each query point.
#'
#' \code{sum} returns nearest point from data coordinates for each query
#' coordinates.
#'
match.nearest <- function(query.x, query.y, data.x, data.y) {
  query <- cbind(query.x, query.y)
  data <- cbind(data.x, data.y)

  get.knnx(data, query, k=1)
}

#' Left join on dataframes by mapping nearest point in data to each query point.
#'
#' \code{left_join.by.nearest} returns nearest point from data coordinates for each query
#' coordinates.
#'
left_join.by.nearest <- function(query.df, data.df,
                                 query.x = 'long', query.y = 'lat',
                                 data.x = 'long', data.y = 'lat',
                                 dist = FALSE) {
  # get matches
  matches <- match.nearest(query.df[,query.x],
                           query.df[,query.y],
                           data.df[,data.x],
                           data.df[,data.y])

  output <- query.df %>% mutate(match.index = matches$nn.index)

  if (dist) output$nn.dist <- matches$nn.dist

  output <- data.df %>%
    select(-lat, -long) %>%
    mutate(i = 1:nrow(data.df)) %>%
    right_join(output, by=c('i'='match.index')) %>%
    select(-i)

  return(output)
}


