# Week 18

## Traffic

I discovered a bug in my code for cleaning the ride data and weather data: I did
not include the timezone in the information. Thus, I realized all my weather and
traffic indicators were totally wrong. I fixed that, and there seems to be more
of an effect of traffic in the non-multilevel regression.

However, I am thinking it might be useful to have a slightly more involved model
for traffic. Right now I am just treating traffic by having a binary "Rush Hour"
indicator, based more on hearsay. But I think I would like to also explore a 
model where I just use time of day. It might be useful to have a periodic
function used in the regression for time of day. Thoughts?
