library(dplyr)
library(lubridate)
library(caret)

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

# Separate training data
inTraining <- createDataPartition(rides.scaled$id, p = .75, list = FALSE)

training <- rides.scaled[inTraining,]
testing <- rides.scaled[-inTraining,]


# Now fit the models

library(rstan)
#package the data for stan
data = list(
  nY = length(rides.scaled$stressful)
  , Y = as.numeric(rides.scaled$stressful)
  , l = as.numeric(rides.scaled$log.length)
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
)

#print a summary table
print(out)
