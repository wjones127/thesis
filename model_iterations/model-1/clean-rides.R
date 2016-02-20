suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(lubridate))


# Load the GeoJSON
bikeroutes.shapefile <- readOGR("./tips.json",
                                "OGRGeoJSON", p4s="+proj=tmerc +ellps=WGS84")

# Create dataframes
bikeroutes <- fortify(bikeroutes.shapefile) %>% tbl_df()
rides <- bikeroutes.shapefile@data %>%
  select(rating,
         rating_text,
         owner__pk,
         original_trip_length,
         created,
         pk,
         rr_transformation) %>%
  # No need to have the actual primary keys here. Not good for security anyways.
  mutate(owner__pk = as.factor(as.numeric(owner__pk)),
         pk = as.factor(as.numeric(pk))) %>%
  tbl_df()

# Eliminate extra copies and out of Portland Rides
bikeroutes$id <- bikeroutes$group %>% as.character() %>% as.numeric() %>% ceiling()

not.in.portland <- bikeroutes %>%
  filter(lat < 45.462 | lat > 45.549 | long > -122.577 | long < -122.722) %>%
  distinct(id) %>%
  .$id

rides <- rides %>%
  mutate(id = 1:nrow(rides)) %>%
  filter(!id %in% not.in.portland) %>%
  filter(rr_transformation == 'simplify') %>%
  distinct(pk)


# Clean up ride level variables

stressful <- function(rating) {
  ifelse(rating > 0,
         ifelse(rating == 1,
                FALSE,
                TRUE),
         NA)
}

rides <- rides %>%
  mutate(stressful = stressful(rating),
        datetime = ymd_hms(created)) %>%
  select(id, stressful, datetime, owner__pk, original_trip_length) %>%
  rename(rider = owner__pk,
         length = original_trip_length) %>%
  # Gotta change to pacific time
  mutate(datetime = with_tz(datetime, tzone="America/Los_Angeles"))

summary(rides$datetime)

save(rides, compress=TRUE, file="./rides.RData")

