library(dplyr)
library(lubridate)
library(caret)
library(arm)
library(gamm4)
library(gridExtra)
library(ggplot2)
library(binom)
library(ggthemes)

# Load data
load('./rides.RData')
load('./weather_daily.RData')
load('./rain_hourly.RData')

# Join in various data sources
rides.final <- rides %>%
  mutate(date = floor_date(datetime, "day")) %>%
  left_join(weather, by = "date") %>%
  mutate(datetime_hour = floor_date(datetime, "hour")) %>%
  left_join(rain, by=c("datetime_hour" = "datetime"))

rides.final <- mutate(rides.final, time = datetime)
year(rides.final$time) <- 2015
month(rides.final$time) <- 1
day(rides.final$time) <- 1
rides.final <- rides.final %>%
  mutate(time = as.numeric(time),
         time = time - min(time),
         time = time / 3600) # convert time from seconds to hours

# Scale the variables
rides.scaled <- rides.final %>%
  mutate(log.length = scale(log(length)),
         length = scale(length)) %>%
  filter(!is.na(stressful),
         !is.na(max.temp),
         !is.na(rain))

# Compute rider average log.length
rider.avg.lengths <- rides.scaled %>%
  group_by(rider) %>%
  summarise(avg.log.length = mean(log.length, na.rm=TRUE))

rides.scaled <- rides.scaled %>%
  left_join(rider.avg.lengths, by="rider")

# Create a scaled hour term
rides.scaled <- rides.scaled %>%
  mutate(hour = scale(hour(datetime)))

summary(rides.scaled$rider)
rides.scaled <- rides.scaled %>% filter(rider %in% c(1,2,4))
rides.scaled$rider <- as.factor(as.numeric(rides.scaled$rider))
levels(rides.scaled$rider) <- 1:3
summary(rides.scaled$rider)

# Create some plots

rider_avg <- rides.final %>%
  filter(!is.na(stressful)) %>%
  group_by(rider) %>%
  summarise(avg_rating = mean(stressful)) %>%
  arrange(desc(avg_rating)) %>%
  mutate(rider = as.character(rider))
rider_avg_plot <- ggplot(rider_avg, aes(x = rider, y =avg_rating)) +
  geom_bar(stat="identity") +
  theme_tufte() +
  labs(title = "Distribution of Average Rider Rating",
       x = "Rider", y = "Proportion of Negative Ratings")

ggsave(rider_avg_plot, file="plots/rider_avgs.pdf", height = 3, width = 5)

length_plot <- prob_var_plot(rides.final, "length", "stressful", 1500) +
  theme_tufte() +
  labs(title = "Distribution of Stressful Rating by Length",
       x = "length of ride", y = "prob. of stressful rating")

ggsave(length_plot, file="plots/length_prob_plot.pdf", width = 5, height = 3)

hour_plot <- prob_var_plot(rides.final, "time", "stressful", 1.5) +
  theme_tufte() +
  labs(title = "Distribution of Stressful Rating by Time of Day",
       x = "hour of day", y = "prob. of stressful rating") +
  scale_x_continuous(breaks = seq(0, 24, 3))

ggsave(hour_plot, file = "plots/hour_prob_plot.pdf", height = 3, width = 5)

# Separate training data
rides.scaled$index <- 1:nrow(rides.scaled)
inTraining <- numeric(0)
riders <- rides.scaled$rider %>% unique()
for (i in riders) {
  their.rides <- rides.scaled %>%
    filter(rider == i) %>%
    .$index
  rider.ride.indexes <- sample(their.rides,
                               size = ceiling(0.75 * length(their.rides)))
  inTraining <- c(inTraining, rider.ride.indexes)
}
training <- rides.scaled[inTraining,]
testing <- rides.scaled[-inTraining,]


# Additive models :)

model4 <- glmer(stressful ~ 1 + (1|rider) +log.length + rainfall.4h + mean.wind.speed ,
                data = training, family=binomial(link="logit"))

add_model <- gam(stressful ~ s(log.length) + rainfall.4h + mean.wind.speed + s(time, bs="cc"),
    data = training, family=binomial)

add_pred <- predict(add_model, type="response")


add_model_results <- data.frame(training$stressful,
                                training$log.length,
                                add_pred) %>%
  rename(actual = training.stressful, log.length = training.log.length,
         fitted = add_pred)

ggplot(add_model_results, aes(x = log.length, y = fitted)) + geom_point() +
  geom_point(aes(color=actual, y = as.numeric(actual)))

add_model2 <- gamm4(stressful ~ 1 + s(log.length) + rainfall.4h + mean.wind.speed,
                   random =~(1|rider),
                   data = training, family = binomial)

summary(add_model2$mer)

model_train_results <- data.frame(training$stressful) %>% rename(actual = training.stressful)
model_train_results$model1 <- predict(add_model, type="response")
model_train_results$model2 <- predict(add_model2$gam, type="response")
model_train_results$prev_model <- predict(model4, type="response")

train_sep_plots <- arrangeGrob(separation.plot(model_train_results, "actual", "model1"),
            separation.plot(model_train_results, "actual", "model2"),
            separation.plot(model_train_results, "actual", "prev_model"),
            ncol=1)
plot(train_sep_plots)

model_test_results <- data.frame(testing$stressful) %>% rename(actual = testing.stressful)
model_test_results$model1 <- predict(add_model, type="response", newdata=testing)
model_test_results$model2 <- predict(add_model2$gam, type="response", newdata=testing)
model_test_results$prev_model <- predict(model4, type="response", newdata=testing)


test_sep_plots <- arrangeGrob(separation.plot(model_test_results, "actual", "model1"),
                              separation.plot(model_test_results, "actual", "model2"),
                              separation.plot(model_test_results, "actual", "prev_model"),
                              ncol=1)
plot(test_sep_plots)

# Now fit the models

library(rstan)
#package the data for stan
data = list(
  nY = length(rides.scaled$stressful)
  , Y = as.numeric(rides.scaled$stressful)
  , l = as.numeric(rides.scaled$log.length)
  , rider = as.numeric(rides.scaled$rider)
)

#compile the model (takes a minute or so)
model = rstan::stan_model(file=list.files(pattern='.stan'))

#evaluate the model
sampling_iterations = 2e4 #best to use 1e3 or higher
out = rstan::sampling(
  object = model
  , data = data
  , chains = 1
  , iter = sampling_iterations
  , warmup = sampling_iterations/2
  , refresh = sampling_iterations/10 #show an update @ each %10
  , seed = 1
  , init = list(list(beta_length = 2,
                     sigma_a = 1,
                     mu_a = -2,
                     a = c(1, 1, 1)))
)

#print a summary table
print(out)

library("shinystan")
my_sso <- launch_shinystan(out)


# Make some fake data
num_rides <- 10000
num_riders <- 5
riders <- 1:num_riders
rider_intercepts <- rnorm(num_riders, -4, 4)
ride_lengths <- log(rnorm(num_rides, 2000, 1000)^2)
ride_rider <- sample(riders, 1000, replace=TRUE)
fake_data <- data.frame(ride_lengths, ride_rider)
fake_data <- fake_data %>%
  mutate(stressful = invlogit(rider_intercepts[ride_rider] + 1 * ride_lengths) > 0.5,
         stressful = as.numeric(stressful))

hist(exp(fake_data$ride_lengths))
hist(fake_data$ride_rider)
hist(fake_data$stressful)
