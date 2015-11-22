# Week 10 Research Log

This week I focused on getting a dataframe of ride data composed of segments of
a road network, rather than as line strings. This was harder than I thought it
would be.

My data source for the road network was the bicycle network dataset from
civicapps.com. One of my first attempts was to simply map each vertex from 
rides to the nearest vertex of the road network. This was meant to be a
simplistic way to get the dataframe for now, but it turned out not to be that
simple at all.

The way I tried to compute that was by, for each point in a ride, calculating
the distance to every point in the road network and then taking the minimum.
Obviously, this was very inefficient, and I was never able to get the calculation
to complete. And if it takes forever for only the rides of five riders, it will
take far longer on a larger data set.

I also tried to see if the matched data was already made up into segments, but
that was not the case. See the `to_road_segments.md` file in the analysis folder
for more details on that.

# Potential Data points
- Traffic signals
- Grade
- Bike infrastructure

