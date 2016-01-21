# Week 15

## Possible models

Here I'd like to write down several possible models. One new idea I've had for
modelling is using segment popularity on the segment level as a predictor for
ride rating.

rating ~ (1 | rider) + temp + rush.hour +


## Map Matching

I keep on coming back to this. More and more I get the sense that the map
matching they have done won't be sufficient. It looks like the routes
have  nearly been roughly snapped, but a lot of strays, rather than actually
mapped to segments. I may have to quickly find a way to snap it.

This could be really good though, if I am able to match it directly to the 
bicycle network from CivicApps.

Here is one promising library: <https://github.com/Project-OSRM/osrm-backend/wiki>


## Progress on cleaning data

I've finally started actually cleaning most of my data better. I've created the
folder `data-raw` to hold the raw data as well as the scripts that clean the
data. The nice thing here is that I can now just have those scripts run on the
data when I run the models. 

